# encoding: utf-8

class ArticlesController < ApplicationController
  before_action :signed_in_user,
                only: [:index, :show, :edit, :update, :destroy]

  def show
    @article = Article.find(params[:id])
    @picture = @article.pictures.build
    @pictures = @article.pictures.paginate(page: params[:page], per_page: 5)
  end
  
  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      flash[:success] = "お知らせが登録されました!"
      redirect_to @article
    else
      render 'new'
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(article_params)
      flash[:success] = "お知らせは更新されました！"
      redirect_to @article
    else
      render 'edit'
    end
  end

  def index
    #@articles = Article.all
    @articles = Article.where(group_id: current_user.group_id).order("created_at DESC")
  end

  def destroy
    Article.find(params[:id]).destroy
    flash[:success] = "お知らせは削除されました！"
    redirect_to articles_url
  end
    
  private
    # Never trust parameters from the scary internet, only allow the white
    # list through.
    def article_params
      params.require(:article).permit(:title, 
                                      :group_id,
                                      :user_id,
                                      :date,
                                      :content)
    end  

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "サインインしてください"
      end
    end
end
