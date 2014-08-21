require 'rails_helper'

RSpec.describe UsersController, :type => :controller do


  context 'Log in as an ADMIN' do
    describe "GET index" do
      before do

        3.times do |i|
          User.create!(
            username: "User #{ i }",
            email: "user#{i}@test.com",
            native_country: "Australia",
            password:'user#{i}',
            password_confirmation: 'user#{i}'
            )
        end

        @admin = User.create!(
          username: "admin",
          email: "admin@test.com",
          native_country: "Australia",
          admin: true,
          password:'admin-aus',
          password_confirmation: 'admin-aus'
        )

        get :index, nil, { user_id: @admin.id }

      end

      describe 'as HTML' do

        it 'should respond with a status 200' do
          expect(response).to be_success
          expect(response.status).to eq(200)
        end

        it 'should set an instance variable with the users' do
          expect(assigns(:users)).to be
          expect(assigns(:users).length).to eq(4)
          expect(assigns(:users)).to eq(User.all)
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
          expect(users.length).to eq(4)
          expect(users.first["username"]).to eq("User 0")
          expect(users.first["email"]).to eq('user0@test.com')
          expect(users.first["native_country"]).to eq('Australia')
        end
      end # AS JSON

    end # GET INDEX AS AN ADMIN
  end

  context 'Log in as an USER' do
    before do
      @user = User.create!(
        username: "user1",
        email: "user1@test.com",
        native_country: "Australia",
        admin: false,
        password:'user1-aus',
        password_confirmation: 'user1-aus'
      )

      get :index, nil, {user_id: @user.id}
    end

    describe 'GET index' do
      it 'should redirect to root path' do
        expect(response).to redirect_to(root_path)
      end
    end
  end # GET INDEX AS AN USER

  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to be_success
    end
  end


  describe "POST /users/" do
    describe "with VAILD data" do

      before do
        post :create, user:{
          username: "user1",
          email: "user1@test.com",
          native_country: "Australia",
          password:'user1_aus',
          password_confirmation: 'user1_aus'
          }
      end
      it 'automatically log the user in' do
        expect(session[:user_id]).to eq(User.first.id)
      end

      it 'should redirect to pages' do
        expect(response.status).to eq(302)
        expect(response).to redirect_to( pages_path )
      end

      it 'should increase the number of User' do
        expect(User.count).to eq(1)
      end
    end # with vaild data

    describe 'with INVAILD data' do
      before do
        post :create, user: { username: "" }
      end

      it 'should redirect to the new template' do
        expect(response.status).to eq(302)
        expect(response).to redirect_to(new_user_path )
      end

      it 'should not increase the number of User' do
        expect(User.count).to eq(0)
      end
    end # with invaild data
  end # POST USERS

  describe "GET show" do

    context 'When user log in' do
      before do
        @user1 = User.create!(
          username: "user1",
          email: "user1@test.com",
          native_country: "Australia",
          password:'user1-aus',
          password_confirmation: 'user1-aus'
        )
        #sign_in(@user1)
        get :show, { :id => @user1.id }, { user_id: @user1.id }

      end

      describe "as HTML" do
        it "returns http success" do
          expect(response).to be_success
        end

        it 'should assign the requested user as @user' do
          expect(assigns(:user)).to eq(@user1)
        end

        it 'should render the user show' do
          expect(response).to render_template('show')
        end
      end # AS HTML

      describe "as JSON" do
        before do
          get :show, {:id => @user1.id, :format => :json }
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
          user = JSON.parse(response.body)
          expect(response.body).to eq(@user1.to_json)
          # this is same as,
          ## expect(user["username"]).to eq("user1")
          ## expect(user["email"]).to eq('user1@test.com')
          ## expect(user["native_country"]).to eq('Australia')
          ## expect(user["native_language"]).to eq('English')
        end

      end # AS JSON
    end # GET SHOW / USER.PRESENT?

    context 'When the user is NILL' do
      before do
        @user1 = User.create!(
          username: "user1",
          email: "user1@test.com",
          native_country: "Australia",
          password:'user1-aus',
          password_confirmation: 'user1-aus'
        )
        #sign_in(@user1)
        get :show, { id: @user1.id }, {user_id: 1222}
        # this means the user is not loged in! no current user id
      end

      it 'should redirect to root_path' do
        expect(response).to redirect_to(pages_path)
      end
    end # GET SHOW / USER.NIL?
  end # GET SHOW

  describe "GET edit" do

    context 'When the user\'s id is same as current user\'s id' do
      before do
        @user1 = User.create!(
          username: "user1",
          email: "user1@test.com",
          native_country: "Australia",
          password:'user1-aus',
          password_confirmation: 'user1-aus'
        )

        get :edit, { :id => @user1.id }, { user_id: @user1.id }

      end

      it "returns http success" do
        expect(response).to be_success
      end

      it 'should assign the requested user as @user' do
        expect(assigns(session[:user_id])).to eq(@user1_id)
      end

      it "should render the user edit" do
        expect(response).to render_template('edit')
      end
    end # GET EDIT / USER.ID === CURRENT_USER.ID

    context 'When the user\'s id is NOT equal to current user\'s id' do
      before do
        @user1 = User.create!(
          username: "user1",
          email: "user1@test.com",
          native_country: "Australia",
          password:'user1-aus',
          password_confirmation: 'user1-aus'
        )

        get :edit, { id: @user1.id }

      end

      it 'should redirect to root path' do
        expect(response).to redirect_to(pages_path)
      end
    end # GET EDIT / USER.ID !=== CURRENT_USER.ID
  end # GET EDIT


  describe "PUT update" do
    describe "with VAILD data" do
      before do
        @user1 = User.create(
          username: "user1",
          email: "user1@test.com",
          native_country: "Australia",
          password:'user1-aus',
          password_confirmation: 'user1-aus'
        )

        # user: { actual data to edit! }
        put :update, { id: @user1.id, user: {
          username: @user1.username,
          email: @user1.email,
          native_country: @user1.native_country,
        }}, { user_id: @user1.id }



      end

      it "updates the requested user" do
        @user1.reload
      end

      it "should assign the requested user as @user" do
        expect(assigns(:user)).to eq(@user1)
      end

      it "should redirect to the user show" do
        expect(response).to redirect_to(user_path(assigns(:user)) )
      end

    end

    describe "with INVAILD data" do
      before do
        @user1 = User.create(
          username: "user1",
          email: "user1@test.com",
          native_country: "Australia",
          password:'user1-aus',
          password_confirmation: 'user1-aus'
        )

        put :update, { id: @user1.id, user: {
          username: @user1.username,
          email: "",
          native_country: @user1.native_country,
        }}, { user_id: @user1.id }
      end

      it "should assign the requested user as @user" do
        expect(assigns(:user)).to eq(@user1)
      end

      it "re-direct to the user edit" do
        expect(response.body).to redirect_to(edit_user_path(@user1))
      end

    end

  end # PUT UPDATE

  describe "DELETE user" do
    before do
      @user1 = User.create!(
        username: "user1",
        email: "user1@test.com",
        native_country: "Australia",
        password:'user1-aus',
        password_confirmation: 'user1-aus'
      )

      # @admin = User.create!(
      #   username: "user2",
      #   email: "user2@test.com",
      #   native_country: "Australia",
      #   password:'user2-aus',
      #   password_confirmation: 'user2-aus'
      # )

    end

    it "should destroy the requested user" do
       expect{ delete :destroy, id: @user1.id, user_id: @user1.id
        }.to change{User.count}.by(0)
    end

    it "should re-direct to the root" do
      delete :destroy, id: @user1.id, user_id: @user1.id
      expect(response).to redirect_to(pages_path)
    end

  end # DELETE

  describe "GET mynews" do
    before do
       @user1 = User.create!(
        username: "user1",
        email: "user1@test.com",
        native_country: "Australia",
        password:'user1-aus',
        password_confirmation: 'user1-aus'
      )
       @user1.categories << Category.find_by(title: 'Art')
       @user1.save

       get :mynews, { :id => @user1.id }, { user_id: @user1.id }
    end

    describe 'The user logged in' do
      # it "returns http success" do
      #     expect(response).to be_success
      # end

      it 'should assign the requested user as @user' do
        expect(assigns(session[:user_id])).to eq(@user1_id)
      end

      it 'should assgin @countries' do
        expect(assigns(:countries)).to eq(Country.countries_list)
      end

      it 'should assgin User\'s categories as @categories' do
        expect(assigns(:categories)).to eq(Category.find_by(title: 'Art'))
      end
    end

    describe 'The user dosen\'t log in' do
      it 'should redirect to root path' do
        expect(response).to redirect_to(pages_path)
      end
    end
  end
end
