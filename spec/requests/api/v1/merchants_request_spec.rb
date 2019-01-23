require 'rails_helper'

describe "merchants API" do
  it "Sends a list of merchants" do
    create_list(:merchant, 3)

    get "/api/v1/merchants"

    merchants = JSON.parse(response.body)
    expect(merchants.count).to eq(3)
    expect(response).to be_successful
  end

  it "send one specific merchant in return" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["id"]).to eq(id)
  end
end
