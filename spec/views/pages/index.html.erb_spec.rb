require 'rails_helper'

RSpec.describe "pages/index.html.erb", :type => :view do
  it 'should respond with a status 200' do
    expect(response).to be_success
    expect(response.status).to eq(200)
  end
end
