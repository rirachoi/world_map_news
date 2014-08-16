require 'rails_helper'

RSpec.describe "user/show.html.erb", :type => :view do
  before(:each) do
    @user = assign(:user, User.create!(
      username: "user1",
      email: "user1@test.com",
      native_country: "Australia",
      native_language: "English",
      password:'user1-aus',
      password_confirmation: 'user1-aus'
    ))
  end

  # it "renders attributes in <p>" do
  #   render
  #   expect(rendered).to match(/Title/)
  #   expect(rendered).to match(/MyText/)
  # end

end
