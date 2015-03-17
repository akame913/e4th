class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.integer :group_id
      t.integer :user_id
      t.string :date
      t.text :content

      t.timestamps
    end
  end
end
