class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :native_country
      t.string :native_language, :default => 'English'
      t.string :password_digest
      t.boolean :admin, :default => false

      t.timestamps
    end
  end
end
