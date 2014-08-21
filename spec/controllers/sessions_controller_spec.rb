require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do

  # before do
  #   @user1 = User.create!(
  #     username: "user1",
  #     email: "user1@test.com",
  #     native_country: "Australia",
  #     password:'user1-aus',
  #     password_confirmation: 'user1-aus'
  #   )
  # end

  # describe "GET new" do
  #   it "returns http success" do
  #     get :new
  #     expect(response).to be_success
  #   end
  # end

  # describe "POST login" do
  #   describe "found the user" do
  #     it 'should assgin the user as current user' do
  #       post :login, { id: @user1.id, user: {
  #         email: @user1.email,
  #         password: @user1.password
  #       }}, { user_id: @user1.id }
  #       expect(assigns(session[:user_id])).to eq(@user1.id)
  #     end
  #   end

  #   describe "no matched user" do
  #     it 'should show flash' do
  #       expect(flash[:notice]).to eq('Invalid login. Please try again')
  #     end

  #     it 'should redirect to login path' do
  #       expect(response).to redirect_to(login_path)
  #     end
  #   end
  # end

  # describe "DELETE logout" do
  #   it "destory the session" do
  #     delete :destory, id: @user1.id, user_id: nil
  #   end

  #   it 'should redirect to root path' do
  #     expect(response).to redirect_to(pages_path)
  #   end
  # end

end