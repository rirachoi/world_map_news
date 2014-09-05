require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do

  before do
    @user1 = User.create!(
      username: "user1",
      email: "user1@test.com",
      native_country: "Australia",
      password:'user1-aus',
      password_confirmation: 'user1-aus'
    )
  end

  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to be_success
    end
  end

  describe "POST login" do
    describe "found the user" do
      it 'should assgin the user as current user' do
        post :create, { email: @user1.email, password: @user1.password }
        expect(session[:user_id]).to eq(@user1.id)
        expect(response).to redirect_to(pages_path)
      end
    end

    describe "no matched user" do
      it 'should show flash and redirect to login path' do
        post :create, { email: "", password: @user1.password }
        expect(flash[:notice]).to_not be_nil
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe "DELETE logout" do
    it "destory the session and redirect to pages path" do
      delete :destroy
      expect(session[:user_id]).to be_nil
      expect(response).to redirect_to(pages_path)
    end
  end

end