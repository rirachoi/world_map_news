require 'rails_helper'

RSpec.describe UsersController, :type => :controller do


# Users Index will be shown only to Admin.
  context 'Log in as an ADMIN' do
    describe "GET index" do
      # Create Users and an admin
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

        #### you can also do,
        #### before(:each) { User.create( username: ---, email: --- )}

        # index url does not need to get id so it is nil.
        get :index, nil , { user_id: @admin.id }

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

  #When a user who is not an admin tried to see index page
  context 'Log in as an USER' do
    #Create a single user
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

  ####### CREATE A NEW USER - It was challenging..but I made it yay!!
  describe "POST /users/" do
    # When user correctly filled all personal data.
    describe "with VALID data" do
      describe "When the user saved" do
        before do
          post :create, user:{
            username: "user1",
            email: "user1@test.com",
            native_country: "Australia",
            password:'user1_aus',
            password_confirmation: 'user1_aus'
          }
        end

        it 'should increase the number of User' do
          expect(User.count).to eq(1)
        end

        it 'automatically log the user in' do
          expect(session[:user_id]).to eq(User.first.id)
        end

        it 'should redirect to pages' do
          expect(response.status).to eq(302)
          expect(response).to redirect_to( pages_path )
        end
      end

      describe "When the user didn\'t save" do
        # user is not saved because the data is invalid
        before do
          post :create, user:{
            username: "user1",
            email: "user1@test.com",
            native_country: "Australia",
            password:'user1_aus',
            password_confirmation: 'user2_aus'
          }
        end

        it 'shouldn\'t increase the number of User' do
          expect(User.count).to eq(0)
        end

        it "should redirect to new_user_path" do
          expect(response).to redirect_to( new_user_path )
        end
      end
    end # with VALID data

    describe 'with INVALID data' do
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
    end # with INVALID data
  end # POST USERS

  # User's show page
  describe "GET show" do

    context 'When user logs in' do
      before do
        @user1 = User.create!(
          username: "user1",
          email: "user1@test.com",
          native_country: "Australia",
          password:'user1-aus',
          password_confirmation: 'user1-aus'
        )

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

    # access to the show page without loggin in
    context 'When the user doesn\'t log in' do
      before do
        @user1 = User.create!(
          username: "user1",
          email: "user1@test.com",
          native_country: "Australia",
          password:'user1-aus',
          password_confirmation: 'user1-aus'
        )

        get :show, { id: @user1.id }, { user_id: nil}
        # this means the user doesn't log in! no current user id
      end

      it 'should redirect to pages_path' do
        expect(response).to redirect_to(pages_path)
      end
    end # GET SHOW / USER.NIL?
  end # GET SHOW

  describe "GET edit" do
    # Access to Edit page when user loged in
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

      # make sure this user's id is same as session user's id
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

        get :edit, { id: @user1.id }, { user_id: 1234 }

      end

      it 'should redirect to pages path' do
        expect(response).to redirect_to(pages_path)
      end
    end # GET EDIT / USER.ID !=== CURRENT_USER.ID
  end # GET EDIT


  ###### UPDATE user's details. It was confusing...but I made it!!!!!!
  describe "PUT update" do
    describe "with VALID data" do

      describe "When the changes is saved" do
        before do
          @user1 = User.create(
            username: "user1",
            email: "user1@test.com",
            native_country: "Australia",
            password:'user1-aus',
            password_confirmation: 'user1-aus'
          )

          #  { user's id, user: - write actual data to edit!- }, { session user.id}
          put :update, { id: @user1.id, user: {
            username: @user1.username,
            email: @user1.email,
            native_country: @user1.native_country,
          }}, { user_id: @user1.id }
        end

        # show the edit page with the user's details
        it "updates the requested user" do
          @user1.reload
        end

        # The edit user is same as the user accessed the edit page
        it "should assign the requested user as @user" do
          expect(assigns(:user)).to eq(@user1)
        end

        it "should redirect to the user show" do
          expect(response).to redirect_to(user_path(assigns(:user)) )
        end
      end # when user is saved

      describe "When the changes are not saved" do
        before do
          @user1 = User.create(
            username: "user1",
            email: "user1@test.com",
            native_country: "Australia",
            password:'user1-aus',
            password_confirmation: 'user1-aus'
          )

          # { user's id, user: - write actual data to edit!- }, { session user.id}
          # this won't be saved because the email is wrong data
          put :update, { id: @user1.id, user: {
            username: @user1.username,
            email: "",
            native_country: @user1.native_country,
          }}, { user_id: @user1.id }
        end

        # show the edit page with the user's details
        it 'should redirect to eidt_path' do
          expect(response).to redirect_to(edit_user_path(assigns(:user)))
        end
      end # when the changes are not saved
    end # with valid data

    describe "with INVALID data" do
      before do
        @user1 = User.create(
          username: "user1",
          email: "user1@test.com",
          native_country: "Australia",
          password:'user1-aus',
          password_confirmation: 'user1-aus'
        )

        # when the user submits empty email address(invalid data)
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


  # Destroy user.
  describe "DELETE user" do
    before do
      @user1 = User.create!(
        username: "user1",
        email: "user1@test.com",
        native_country: "Australia",
        password:'user1-aus',
        password_confirmation: 'user1-aus'
      )

      delete :destroy, { id: @user1.id}, { user_id: @user1.id }

    end

    it "should assign the requested user as @user" do
        expect(assigns(:user)).to eq(@user1)
    end

    # checking the number of users
    it "should destroy the requested user" do
      expect{ delete :destroy, id: @user1.id, user_id: @user1.id
        }.to change{User.count}.by(0)
        # to change{User, "count"}
      # because the only user has been deleted the number of users is zero.
    end

    # after delete going to index page to see the users list(for admin)
    it "should re-direct to the root" do
      expect(response).to redirect_to(pages_path)
    end

  end # DELETE

  # Accessing user's customized categories page.
  describe "GET mynews" do
    before do
      @user1 = User.create!(
        username: "user1",
        email: "user1@test.com",
        native_country: "Australia",
        password:'user1-aus',
        password_confirmation: 'user1-aus'
      )

      # Creating a category - because the category test DB is empty
      @category = Category.create!(
        title: 'Art',
        api_id: 4 )

      # push the new category to user's categories (user's category preference)
      @user1.categories << Category.first
      @user1.save
      # make sure save this!

      get :mynews, { :id => @user1.id }, { user_id: @user1.id }
    end

    describe 'The user logged in' do
      it "returns http success" do
          expect(response).to be_success
      end

      it 'should assign the requested user as @user' do
        expect(assigns(session[:user_id])).to eq(@user1_id)
      end

      # because countries come from class method it doesn't need to create.
      it 'should assgin @countries' do
        expect((assigns(:countries)).first).to eq((Country.countries_list).first)
      end

      it 'should assgin User\'s categories as @categories' do
        expect(assigns(:categories)).to eq(@user1.categories)
      end
    end

    describe 'The user dosen\'t log in' do
      before do
       @user2 = User.create!(
        username: "user2",
        email: "user2@test.com",
        native_country: "Australia",
        password:'user2-aus',
        password_confirmation: 'user2-aus'
      )

       # set the session's id to random number.
       get :mynews, { :id => @user2.id }, { user_id: 1233 }
      end

      it 'should redirect to root path' do
        expect(response).to redirect_to(pages_path)
      end
    end
  end
end
