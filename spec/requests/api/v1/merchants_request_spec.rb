require 'rails_helper'

describe "merchants API" do
  it "Sends a list of merchants" do
    create_list(:merchant, 3)

    get "/api/v1/merchants"

    merchants = JSON.parse(response.body)
    expect(merchants["data"].count).to eq(3)
    expect(response).to be_successful
  end

  it "send one specific merchant in return" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["data"]["id"].to_i).to eq(id)
  end

  it "It can find a spefic merchant based on different parameters" do
    merchant_1 = create(:merchant)

    get "/api/v1/merchants/find?id=#{merchant_1.id}"

    merchant = JSON.parse(response.body)

    # binding.pry
    expect(response).to be_successful
    expect(merchant["id"]).to eq(merchant_1.id)
    expect(merchant["name"]).to eq(merchant_1.name)
    # expect(merchant["created_at"]).to eq(merchant_1.created_at)
    # expect(merchant["updated_at"]).to eq(merchant_1.updated_at)
  end
end
