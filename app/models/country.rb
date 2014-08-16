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
end
