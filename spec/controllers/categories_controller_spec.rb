require 'rails_helper'

RSpec.describe CategoriesController, :type => :controller do

  describe "GET index" do

    before do

      3.times do |i|
        Category.create!(
          title: "Category #{ i }",
          api_id: "#{ i }",
          )
      end
    get :index
    end

    describe 'as HTML' do

      it 'should respond with a status 200' do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it 'should set an instance variable with the categories' do
        expect(assigns(:categories)).to be
        expect(assigns(:categories).length).to eq(3)
        expect(assigns(:categories)).to eq(Category.all)
      end

      it 'should render the categories index' do
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

      it 'should have the name of category in the JSON' do
        categories = JSON.parse(response.body)
        expect(categories.length).to eq(3)
        expect(categories.first["title"]).to eq("Category 0")
        expect(categories.first["api_id"]).to eq(0)
      end
    end # AS JSON

  end # GET INDEX
end

# describe "GET show" do

#     before do
#       @category1 = Category.create!(
#         title: "category1",
#         api_id: "1",
#       )

#       get :show, { id: @category1.id }

#     end

#     describe "as HTML" do
#       it "returns http success" do
#         expect(response).to be_success
#       end

#       it 'should assign the requested category as @category' do
#         expect(assigns(:category)).to eq(@category1)
#       end

#       it 'should render the category show' do
#         expect(response).to render_template('show')
#       end
#     end #AS HTML

#     describe "as JSON" do
#       before do
#         get :show, {:id => @categoy1.id, :format => :json }
#       end

#       it 'should respond with a status 200' do
#         expect(response).to be_success
#         expect(response.status).to eq(200)
#       end

#       it 'should give content type as JSON' do
#         expect(response.content_type).to eq('application/json')
#       end

#       it 'should parse as valid JSON' do
#         expect(lambda { JSON.parse(response.body) }).to_not raise_error
#       end

#       it 'should have the name of user in the JSON' do
#         user = JSON.parse(response.body)
#         expect(response.body).to eq(@categoy1.to_json)
#       end

#     end # AS JSON
#   end # GET SHOW


