# encoding: utf-8

class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(name: params[:session][:name])
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or root_path
    else
      flash.now[:error] = 'NameとPasswordが一致しません！'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
