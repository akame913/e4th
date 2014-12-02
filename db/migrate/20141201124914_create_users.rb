class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :name
      t.string  :family
      t.string  :given
      t.string  :maiden
      t.string  :pobox
      t.string  :region
      t.string  :city
      t.string  :street
      t.string  :tel
      t.string  :mobile
      t.string  :notes
      t.string  :email
      t.string  :password_digest
      t.string  :remember_token

      t.timestamps
    end
  end
end
