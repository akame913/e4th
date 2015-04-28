class CreateDocs < ActiveRecord::Migration
  def change
    create_table :docs do |t|
      t.integer :group_id
      t.integer :user_id
      t.string  :name
      t.string  :description
      t.string  :doc_type
      t.binary  :doc_data
      
      t.timestamps
    end
    add_index :docs, [:group_id, :user_id]
  end
end
