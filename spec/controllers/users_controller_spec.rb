require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  describe "GET index" do
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

      get :index

    end

    describe 'as HTML' do

      it 'should respond with a status 200' do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it 'should set an instance variable with the users' do
        expect(assigns(:users)).to be
        expect(assigns(:users).length).to eq(3)
        expect(assigns(:users).first.class).to eq(User)
        expect(assigns(:users).first.username).to eq('User 0')
        expect(assigns(:users).first.email).to eq('user0@test.com')
        expect(assigns(:users).first.native_country).to eq('Australia')
        expect(assigns(:users).first.native_language).to eq('English')
      end

      it 'should render the user index' do
        expect(response).to render_template('index')
      end

    end # AS HTML

    describe 'as JSON' do
      before do
        get :index, :format => :json
      end

      it 'should respond with a status 200' do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it 'should give content type as JSON' do
        expect(response.content_type).to eq('application/json')
      end

      it 'should parse as valid JSON' do
        expect(lambda { JSON.parse(response.body) }).to_not raise_error
      end

      it 'should have the name of user in the JSON' do
        users = JSON.parse(response.body)
        expect(users.length).to eq(3)
        expect(users.first["username"]).to eq("User 0")
        expect(users.first["email"]).to eq('user0@test.com')
        expect(users.first["native_country"]).to eq('Australia')
        expect(users.first["native_language"]).to eq('English')
      end
    end # AS JSON

  end # GET INDEX

  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to be_success
    end
  end


  describe "POST /users/" do
    describe "with a vaild data" do

      before do
        post :create, user:{
          username: "user1",
          email: "user1@test.com",
          native_country: "Australia",
          native_language: "English",
          password:'user1_aus',
          password_confirmation: 'user1_aus'
          }
      end

      it 'should redirect to #show' do
        expect(response.status).to eq(302)
        expect(response).to redirect_to( user_path(assigns(:user)) )
      end

      it 'should increase the number of User' do
        expect(User.count).to eq(1)
      end
    end # with vaild data

    describe 'with invaild data' do
      before do
        post :create, user: { username: "" }
      end

      it 'should redirect to the new template' do
        expect(response).to redirect_to(new_user_path(assigns(:user)) )
      end

      it 'should not increase the number of User' do
        expect(User.count).to eq(0)
      end
    end # with invaild data
  end # POST USERS

  describe "GET show" do

    before do
      @user1 = User.create!(
        username: "user1",
        email: "user1@test.com",
        native_country: "Australia",
        native_language: "English",
        password:'user1-aus',
        password_confirmation: 'user1-aus'
      )

      get :show, { id: @user1.id }

    end

    describe "as HTML" do
      it "returns http success" do
        expect(response).to be_success
      end

      it 'assigns the requested user as @user' do
        expect(assigns(:user)).to eq(@user1)
        # expect(assigns(:user)).to be
        # expect(assigns(:user).length).to eq(1)
        # expect(assigns(:user).class).to eq(User)
        # expect(assigns(:user).username).to eq('user1')
        # expect(assigns(:user).email).to eq('user10@test.com')
        # expect(assigns(:user).native_country).to eq('Australia')
        # expect(assigns(:user).native_language).to eq('English')
      end

      it 'should render the user show' do
        expect(response).to render_template('show')
      end
    end #AS HTML

    # describe "as JSON" do

    # end # AS JSON
  end # GET SHOW




  # describe "GET edit" do
  #   it "returns http success" do
  #     get :edit
  #     expect(response).to be_success
  #   end
  # end

  # describe "GET create" do
  #   it "returns http success" do
  #     get :show
  #     expect(response).to be_success
  #   end
  # end

  # describe "GET update" do
  #   it "returns http success" do
  #     get :show
  #     expect(response).to be_success
  #   end
  # end

  # describe "GET destroy" do
  #   it "returns http success" do
  #     get :index
  #     expect(response).to be_success
  #   end
  # end

end
