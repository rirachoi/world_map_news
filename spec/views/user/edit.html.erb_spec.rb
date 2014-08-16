require 'rails_helper'

RSpec.describe "user/edit.html.erb", :type => :view do
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

  # it "renders the edit post form" do
  #   render

  #   assert_select "form[action=?][method=?]", post_path(@post), "post" do

  #     assert_select "input#post_title[name=?]", "post[title]"

  #     assert_select "textarea#post_content[name=?]", "post[content]"
  #   end
  # end
end
