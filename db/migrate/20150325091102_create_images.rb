class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.integer :article_id
      t.integer :user_id
      t.string :content_type
      t.binary :data, :limit => 1.megabyte

      t.timestamps
    end
  end
end
