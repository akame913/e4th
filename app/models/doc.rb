# encoding: utf-8

class Doc < ActiveRecord::Base
  belongs_to :user
  validates :group_id, :user_id, :name, :description, presence: true

  def uploaded_doc=(doc_field)
    self.name     = base_part_of(doc_field.original_filename)
    self.doc_type = doc_field.content_type.chomp
    self.doc_data = doc_field.read
  end

  def base_part_of(file_name)
#    File.basename(file_name).gsub(/[\A\w._-]/, '')
    File.basename(file_name)
  end

end
