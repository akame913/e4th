# encoding: utf-8

class Micropost < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  validates :content, presence: true, length: { maximum: 140 }
  validates :group_id, presence: true
  validates :user_id, presence: true

  # 与えられたユーザーがフォローしているユーザー達のマイクロポストを返す。
#  def self.from_users_followed_by(user)
#    followed_user_ids = "SELECT followed_id FROM relationships
#                         WHERE follower_id = :user_id"
#    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
#          user_id: user.id)
#  end

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
    self.photo   = binary64
    self.photo_m = binary30
    self.photo_s = binary10
  end

  def base_part_of(file_name)
#    File.basename(file_name).gsub(/[\A\w._-]/, '')
    File.basename(file_name)
  end

end
