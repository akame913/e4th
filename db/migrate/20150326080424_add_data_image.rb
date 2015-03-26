class AddDataImage < ActiveRecord::Migration
  def change
    add_column :images, :data_m, :binary, :limit => 1.megabyte
    add_column :images, :data_s, :binary, :limit => 1.megabyte
    add_index :images, [:article_id, :created_at]
  end
end
