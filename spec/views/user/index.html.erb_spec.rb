require 'rails_helper'

RSpec.describe "user/index.html.erb", :type => :view do
  before do
    3.times do |i|
      User.create!(
        username: "User #{ i }",
        email: "user#{i}@test.com",
        native_country: "Australia",
        native_language: "English",
        password:'user#{i}',
        password_confirmation: 'user#{i}'
      )
    end
  end

  # it "renders a list of posts" do
  #   render
  #   assert_select "tr>td", :text => "Title".to_s, :count => 2
  #   assert_select "tr>td", :text => "MyText".to_s, :count => 2
  # end
end
