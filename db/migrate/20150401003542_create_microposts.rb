class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :microposts do |t|
      t.string :content
      t.integer :group_id
      t.integer :user_id
      t.binary :photo, :limit => 1.megabyte
      t.binary :photo_m, :limit => 1.megabyte
      t.binary :photo_s, :limit => 1.megabyte

      t.timestamps
    end
    add_index :microposts, [:group_id, :user_id, :created_at]
  end
end
