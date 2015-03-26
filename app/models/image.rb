# encoding: utf-8

# config/environment.rbに記入済み
#require 'rubygems'
#require 'RMagick'

class Image < ActiveRecord::Base
  belongs_to :user
  belongs_to :article
  default_scope -> { order('created_at DESC') }
  validates :article_id, presence: true
  validates :user_id, presence: true
  validates_format_of :content_type, 
                      with: /\Aimage/,
                      message: "追加できるのは画像だけです。"
                      
  def uploaded_image=(image_field)
    self.name         = base_part_of(image_field.original_filename)
    self.content_type = image_field.content_type.chomp
    # RMagickで画像取得後リサイズしてバイナリ返還後dataセーブ
    img = Magick::Image.from_blob(image_field.read).shift
    img64 = img.resize_to_fit(640,640)
    img30 = img.resize_to_fit(300,300)
    img10 = img.resize_to_fit(100,100)
    binary64 = img64.to_blob  # 画像からバイナリを取得する
    binary30 = img30.to_blob  # 画像からバイナリを取得する
    binary10 = img10.to_blob  # 画像からバイナリを取得する
    self.data   = binary64
    self.data_m = binary30
    self.data_s = binary10
  end

  def base_part_of(file_name)
#    File.basename(file_name).gsub(/[\A\w._-]/, '')
    File.basename(file_name)
  end
                      
end
