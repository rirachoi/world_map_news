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

require 'rails_helper'

RSpec.describe Country, :type => :model do
  it { is_expected.to have_and_belong_to_many(:users) }
end
