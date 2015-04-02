# encoding: utf-8

class MicropostsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy, :index, :show]
  #before_action :correct_user,   only: :destroy

  def index
    #@microposts = @user.microposts.paginate(page: params[:page])
    @microposts = Micropost.where(user_id: current_user.id).order("created_at DESC").paginate(page: params[:page], per_page: 5)
  end

  def show
    @micropost = Micropost.find(params[:id])
  end

  def edit
    @micropost = Micropost.find(params[:id])
  end
 
  def create
    @micropost = Micropost.new(micropost_params)
    if @micropost.save
      flash[:success] = "一言写真が登録されました!"
      PostMailer.post_email(current_user, @micropost).deliver
      redirect_to root_url
    else
#      @feed_items = []
      flash[:error] = "一言写真は登録できませんでした!"
      redirect_to root_url
#      render 'static_pages/home'
    end
  end

  def destroy
    Micropost.find(params[:id]).destroy
    flash[:success] = "一言写真は削除されました！"
    #@micropost.destroy
    redirect_to root_url
  end

  def download
    @micropost = Micropost.find(params[:micropost_id])
    send_data(@micropost.photo_m,
              filename: @micropost.name,
              type: @micropost.content_type,
              disposition: "inline")
  end

  def download_max
    @micropost = Micropost.find(params[:micropost_id])
    send_data(@micropost.photo,
              filename: @micropost.name,
              type: @micropost.content_type,
              disposition: "inline")
  end

  def download_small
    @micropost = Micropost.find(params[:micropost_id])
    send_data(@micropost.photo_s,
              filename: @micropost.name,
              type: @micropost.content_type,
              disposition: "inline")
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content, :group_id, :user_id, :uploaded_image)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end
