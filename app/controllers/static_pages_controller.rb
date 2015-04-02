# encoding: utf-8

class StaticPagesController < ApplicationController
  def home
    @microposts = Micropost.where(group_id: current_user.group_id).order("created_at DESC").paginate(page: params[:page], per_page: 5) if signed_in?
    @micropost = current_user.microposts.build if signed_in?
  end

  def help
  end

  def about
  end

  def album
  end

  def picture
  end

  def picturefind
    @fstr = params[:fstr]
    @filenames = Dir.glob("app/assets/images/"+@fstr+"/*").map do |f| File.basename f end
  end

end
