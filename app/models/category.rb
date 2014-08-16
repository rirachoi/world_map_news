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
