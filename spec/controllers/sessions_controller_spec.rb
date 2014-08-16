require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do

  before do
    @user1 = User.create!(
      username: "user1",
      email: "user1@test.com",
      native_country: "Australia",
      native_language: "English",
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
    describe "the user is present" do
      before do
        @user1 = User.create(
          username: "user1",
          email: "user1@test.com",
          native_country: "Australia",
          native_language: "English",
          password:'user1-aus',
          password_confirmation: 'user1-aus'
        )
        # post :create, id: @user1.id, user: {
        #   username: @user1.username,
        #   email: @user1.email,
        #   native_country: @user1.native_country,
        #   native_language: @user1.native_language
        # }
      end
      describe "find the user and set to current_user"

        describe "with correct password" do
          it "should assign the user to current_user" do
            post :create, id: @user1.id
            expect(assigns(:user_id)).to eq(@user1.id)
          end

          # it "should create a user session" do
          #   expect{ post :create, user: @user1
          #   }.to change{User.count}.by(1)
          #   session[:user_id].should_not be_nil
          # end
        end

        describe "with incorrect password" do
        end
      end
    end # user.presnet?

    describe "the user is not present" do
      before do
        post :create, user: nil
      end

      it "should assigns the user is nil" do
        expect(assigns[:user]).to eq(nil)
      end

      it "flashes a success message and redirect to login" do
        expect(response).to redirect_to(login_path)
        expect(flash[:notice]).to eq("Invalid login. Please try again")
      end
    end

  # describe "DELETE logout" do
  #   it "returns http success" do
  #     delete :destory
  #     expect(response).to be_success
  #   end
  # end

end