class AddNameToMicropost < ActiveRecord::Migration
  def change
    add_column :microposts, :name, :string
    add_column :microposts, :content_type, :string
  end
end
