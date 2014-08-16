require 'rails_helper'

RSpec.describe CategoriesController, :type => :controller do

  describe "GET index" do
    it 'should respond with a status 200' do
      get :index
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end

  # describe "GET show" do
  #   it "returns http success" do
  #     get :show
  #     expect(response).to be_success
  #   end
  # end

end
