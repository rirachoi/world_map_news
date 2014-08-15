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

class User < ActiveRecord::Base
  has_secure_password
  validates :username, :presence => true, :length => { :minimum => 3 }, :uniqueness => true
  validates :password, :presence => true, :length => { :minimum => 6 }, :on => :create
  validates :email, :presence => true, :uniqueness => true
  validates :native_country, :presence => :true
  validates :native_language, :presence => :true
end
