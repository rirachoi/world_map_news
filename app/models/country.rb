# == Schema Information
#
# Table name: countries
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  country_code :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class Country < ActiveRecord::Base

  has_and_belongs_to_many :users

  def self.get_names
    url = "http://api.feedzilla.com/v1/cultures.json"
    countries_names = HTTParty.get( url )
  end

  # def self.get_categories
  #   country_code = URI.encode( self.option_value )
  #   url = "http://api.feedzilla.com/v1//categories.json?culture_code="
  #   url += country_code
  #   country_categoriesres = HTTParty.get( url )
  # end
end


# Retrieve all countries
# curl http://api.feedzilla.com/v1/cultures.json

# Retrieve all Categories for a Country
# curl http://api.feedzilla.com/v1//categories.json?culture_code=au
## http://api.feedzilla.com/v1//categories.json?culture_code=#{ culture_code }

# OPTIONAL Retrieve Sub Categories for a Category in a Country
# curl http://api.feedzilla.com/v1/categories/548/subcategories.json?culture_code=au
## http://api.feedzilla.com/v1/categories/#{ category_id }/subcategories.json?culture_code=#{ culture_code }

# OPTIONAL Retrieve all Articles in a Sub Category of a Category
# curl http://api.feedzilla.com/v1/categories/26/subcategories/1303/articles.json
##  http://api.feedzilla.com/v1/categories/#{ category_id }/subcategories/#{ subcategory_id }/articles.json

# Retrieve all Articles for a Category in a Country
# curl http://api.feedzilla.com/v1/categories/548/articles.json?culture_code=au
## http://api.feedzilla.com/v1/categories/#{ category_id }/articles.json?culture_code=#{ culture_code }

# Search for articles based on keywords in a category
# curl http://api.feedzilla.com/v1/categories/548/articles/search.json?q=Linux&culture_code=au
## http://api.feedzilla.com/v1/categories/#{ category_id }/articles/search.json?q=#{ search_keyword }&culture_code=#{ culture_code }

# http://api.feedzilla.com/v1/categories/548/articles/search.json?q=Linux&culture_code=au&count=5
## http://api.feedzilla.com/v1/categories/#{ category_id }/articles/search.json?q=#{ search_keyword }&culture_code=#{ culture_code }&count=#{ number_of_results }
