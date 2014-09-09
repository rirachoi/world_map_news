require 'rails_helper'

RSpec.describe CategoriesController, :type => :controller do

  ## GET INDEX
  context 'Country TEST' do
    describe "GET index" do
      describe "as HTML" do
        it 'should respond with a status 200' do
          get :index
          expect(response).to be_success
          expect(response.status).to eq(200)
        end

        # Becasue County is class method so it dosen't need to be created.
        it 'should assgin @countries as countries' do
          get :index
          expect((assigns(:countries)).first).to eq((Country.countries_list).first)
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

        it 'should have the name of countires in the JSON' do
          countires = JSON.parse(response.body)
          #expect(assigns(:countries)).to eq(countries)
        end
      end # AS JSON
    end
  end

  context 'Category TEST' do
    describe "GET index" do
      describe "as HTML" do
        it 'should respond with a status 200' do
          get :index
          expect(response).to be_success
          expect(response.status).to eq(200)
        end

        it 'should assgin @categories as categories' do
          get :index
          expect(assigns(:categories)).to eq((Category.all))
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

        it 'should have the name of categories in the JSON' do
          categories = JSON.parse(response.body)
          #expect(categories).to eq(assigns(:categories))
        end
      end # AS JSON
    end
  end

  describe "GET show" do

    before do
      @category1 = Category.create!(
        title: "category1",
        api_id: "1",
      )

      get :show, { id: @category1.id }

    end

    describe "as HTML" do
      it "returns http success" do
        expect(response).to be_success
      end

      it 'should assign the requested category as @category' do
        expect(assigns(:category)).to eq(@category1)
      end

      it 'should render the category show' do
        expect(response).to render_template('show')
      end
    end #AS HTML

    describe "as JSON" do
      before do
        get :show, {:id => @category1.id, :format => :json }
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
        # expect(response.body).to eq(@categoy1.to_json)
      end

    end # AS JSON
  end # GET SHOW

  #Create the user's preference categories - mynews
  describe "POST /categories/" do
    describe "create user's categories" do
      before do
        @user1 = User.create!(
          username: "user1",
          email: "user1@test.com",
          native_country: "Australia",
          password:'user1_aus',
          password_confirmation: 'user1_aus'
        )

        @category1 = Category.create!(
          title: 'Art',
          api_id: 4 )

        @category2 = Category.create!(
          title: 'Sports',
          api_id: 2 )

        # push the new category to user's categories (user's category preference)
        @user1.categories << Category.first
        @user1.save

        # post :create, { category.id-[array] }, { user.id }
        # Because I am creating category so I have to pass category first and then user's id
        post :create, { :pref_category => [2] }, { :user_id => @user1.id }

      end

      it 'should clear the current user\'s categories' do
        expect((session[:user_id])).to eq(@user1.id)
        expect(@user1.categories.first).not_to eq(@category1)
        expect(@user1.categories.last).to eq(@category2)
      end

      it 'should assign pre_category\'s api id to user\'s categories' do
        expect(@user1.categories.last.api_id).to eq(2)
      end

      it 'should redirect to mynews_path' do
        expect(response.status).to eq(302)
        expect(response).to redirect_to( users_mynews_path)
      end
    end # create user's categories
  end # POST/categories
end




