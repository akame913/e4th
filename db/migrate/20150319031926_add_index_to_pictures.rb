class AddIndexToPictures < ActiveRecord::Migration
  def change
    add_index :pictures, [:article_id, :created_at]
  end
end
