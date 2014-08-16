class CreateCategoriesUsers < ActiveRecord::Migration
  def change
    create_table :categories_users, :id => false do |t|
      t.integer :category_id
      t.integer :user_id
    end
  end
end
