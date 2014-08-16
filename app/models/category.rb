# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  titles     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Category < ActiveRecord::Base
  has_and_belongs_to_many :users
end

# Retrieve all countries
# curl http://api.feedzilla.com/v1/cultures.json

# Retrieve all Categories for a Country
# curl http://api.feedzilla.com/v1//categories.json?culture_code=au

# OPTIONAL Retrieve Sub Categories for a Category in a Country
# curl http://api.feedzilla.com/v1/categories/548/subcategories.json?culture_code=au

# OPTIONAL Retrieve all Articles in a Sub Category of a Category
# curl http://api.feedzilla.com/v1/categories/26/subcategories/1303/articles.json

# Retrieve all Articles for a Category in a Country
# curl http://api.feedzilla.com/v1/categories/548/articles.json?culture_code=au

# Search for articles based on keywords in a category
# curl http://api.feedzilla.com/v1/categories/548/articles/search.json?q=Linux&culture_code=au

# http://api.feedzilla.com/v1/categories/548/articles/search.json?q=Linux&culture_code=au&count=5
