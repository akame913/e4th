# encoding: utf-8

class DocsController < ApplicationController
  before_action :signed_in_user, 
                only: [:index, :show, :edit, :update, :destroy]

  def index
    @docs = Doc.where(group_id: current_user.group_id).order("created_at DESC")
            .paginate(page: params[:page], per_page: 5)
  end
  
  def new
    @doc = Doc.new
  end

  def create
    #@doc = Doc.new(doc_params)
    @doc = current_user.docs.build(doc_params)
    if @doc.save
      flash[:success] = "文書登録されました!"
      redirect_to @doc
    else
      render 'new'
    end
  end

  def download
    @doc = Doc.find(params[:doc_id])
    send_data(@doc.doc_data,
              filename: @doc.name,
              type: @doc.doc_type,
              disposition: "attachment")
  end

  def show
    @doc = Doc.find(params[:id])
  end

  def edit
    @doc = Doc.find(params[:id])
  end

  def update
    @doc = Doc.find(params[:id])
    if @doc.update_attributes(doc_params)
       flash[:success] = "文書更新されました!"
       redirect_to @doc
    else
      render 'edit'
    end
  end

  def destroy
    Doc.find(params[:id]).destroy
    flash[:success] = "文書削除されました!"
    redirect_to docs_url
  end
          
  private
    # Never trust parameters from the scary internet, only allow the white
    # list through.
    def doc_params
      params.require(:doc).permit(:group_id, 
                                  :user_id,
                                  :description,
                                  :uploaded_doc)
    end

    def correct_user
      @doc = current_user.docs.find_by(id: params[:id])
      redirect_to root_url if @doc.nil?
    end
end
