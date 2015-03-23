# encoding: utf-8

class UsersController < ApplicationController
  before_action :signed_in_user,
                only: [:index, :show, :edit, :update, :destroy, :find]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
      
  def index
    #@users = User.paginate(page: params[:page])
    @users = User.all
    respond_to do |format|
      format.html do
        @users = @users.paginate(page: params[:page])
      end
      format.csv do
        send_data render_to_string, filename: "users-#{Time.now.to_date.to_s}.csv", type: :csv
      end
    end
  end

  def import
    # fileはtmpに自動で一時保存される
    User.import(params[:file])
    redirect_to root_url, notice: "名簿を追加・更新しました。"
  end

  def csv
    send_data User.to_csv, filename: "users-sjis-#{Time.now.to_date.to_s}.csv", type: "text/csv; charset=shift_jis"
  end
   
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Ebara 4th!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  def find
    @class = params[:fstr]
    fstr = params[:fstr]
    if fstr == ""
      @users = User.where(group_id: current_user.group_id)
    else
      @users = User.where("name like ?","%" + fstr + "%")
    end
  end    

  private

    def user_params
      params.require(:user).permit(:name, :family, :given, :maiden, :pobox,
                                   :region, :city, :street, :tel, :mobile,
                                   :notes, :email, :password,
                                   :password_confirmation, :group_id)
    end

    # Before actions

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "サインインしてください"
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless (current_user?(@user) ||  current_user.admin?)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
