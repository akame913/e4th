# encoding: utf-8

class PicturesController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_picture,   only: :destroy

  def create

    @picture = Picture.new(picture_params)
#    @picture = article.pictures.build(picture_params)
    if @picture.save
      flash[:success] = "写真が登録されました!"
      redirect_to  article_path(@picture.article_id)
    else
      flash[:error] = "写真登録に失敗しました!"
      redirect_to  article_path(@picture.article_id)
    end
  end

  def destroy
    @picture.destroy
    redirect_to  article_path(@picture.article_id)
  end

  private

    def picture_params
      params.require(:picture).permit(:article_id, :image)
#      params.require(:picture).permit(:image)
    end

    def correct_picture
      @picture = Picture.find_by(id: params[:id])
      redirect_to root_url if @picture.nil?
    end
end
