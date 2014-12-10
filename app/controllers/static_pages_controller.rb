# encoding: utf-8

class StaticPagesController < ApplicationController
  def home
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
