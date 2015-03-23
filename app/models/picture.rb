# encoding: utf-8

class Picture < ActiveRecord::Base
  belongs_to :user
  belongs_to :article
  default_scope -> { order('created_at DESC') }
  validates :article_id, presence: true
  validates :image, presence: true
 
 # photoをattachファイルとする。stylesで画像サイズを定義できる
  has_attached_file :image, 
      styles: { original: "640x640>", medium: "300x300>", thumb: "100x100>" },
      url: "/assets/arts/:id/:style/:basename.:extension", # 画像保存先のURL先
	    path: "#{Rails.root}/public/assets/arts/:id/:style/:basename.:extension" # サーバ上の画像保存先パス

  # ファイルの拡張子を指定（これがないとエラーが発生する）
  validates_attachment :image, 
      content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] },
      less_than: 5.megabytes # ファイルサイズのチェック
end
