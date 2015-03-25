# encoding: utf-8

class ImagesController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy, :index, :show]
  before_action :correct_image,   only: :destroy
  
  def index
    @images = Image.where(user_id: current_user.id).order("created_at DESC").paginate(page: params[:page], per_page: 5)
  end
  
  def create
    @image = Image.new(image_params)
    if @image.save
      flash[:success] = "写真が登録されました!"
      redirect_to  article_path(@image.article_id)
    else
      flash[:error] = "写真登録に失敗しました!"
      redirect_to  article_path(@image.article_id)
    end
  end

  def download
    @image = Image.find(params[:image_id])
    send_data(@image.data,
              filename: @image.name,
              type: @image.content_type,
              disposition: "inline")
  end

  def show
    @image = Image.find(params[:id])
  end

  def edit
    @image = Image.find(params[:id])
  end

  def update
    @image = Image.find(params[:id])
    if @image.update_attributes(image_params)
       flash[:success] = "Image updated"
       redirect_to @image
    else
      render 'edit'
    end
  end

  def destroy
    @image.destroy
    redirect_to  article_path(@image.article_id)
  end
          
  private
    # Never trust parameters from the scary internet, only allow the white
    # list through.
    def image_params
      params.require(:image).permit(:article_id, :user_id, :uploaded_image)
    end

    def correct_image
      @image = Image.find_by(id: params[:id])
      redirect_to root_url if @image.nil?
    end
end
