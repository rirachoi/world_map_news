# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)
#  email           :string(255)
#  native_country  :string(255)
#  native_language :string(255)
#  password_digest :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

require 'rails_helper'

RSpec.describe User, :type => :model do
  it { is_expected.to have_and_belong_to_many(:categories) }
  it { is_expected.to have_and_belong_to_many(:countries) }
end
