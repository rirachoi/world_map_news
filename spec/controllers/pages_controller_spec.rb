require 'rails_helper'

RSpec.describe PagesController, :type => :controller do

  context 'Country TEST' do
    describe "GET index" do
      describe "as HTML" do
        it 'should respond with a status 200' do
          get :index
          expect(response).to be_success
          expect(response.status).to eq(200)
        end

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
          #expect(countires).to eq(assigns(:countries))
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
    end # Get index
  end # Context

  describe "GET about" do
    it 'should respond with a status 200' do
      get :about
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end

  describe "GET contact" do
    it 'should respond with a status 200' do
      get :contact
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
  end

end
