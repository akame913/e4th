# encoding: utf-8

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
    self.data         = image_field.read
  end

  def base_part_of(file_name)
#    File.basename(file_name).gsub(/[\A\w._-]/, '')
    File.basename(file_name)
  end
                      
end
