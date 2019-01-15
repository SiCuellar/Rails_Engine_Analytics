require 'rails_helper'

describe 'Items Api' do
  it ' sends a list of items ' do
    create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to be_succesful
  end

end
