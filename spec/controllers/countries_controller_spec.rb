require 'rails_helper'

RSpec.describe CountriesController, :type => :controller do

  describe "GET index" do
    it 'should respond with a status 200' do
      get :index
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

  end

end
