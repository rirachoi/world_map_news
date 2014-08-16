class CreateCountriesUsers < ActiveRecord::Migration
  def change
    create_table :countries_users, :id => false do |t|
      t.integer :country_id
      t.integer :user_id
    end
  end
end
