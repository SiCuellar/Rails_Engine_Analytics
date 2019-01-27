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

  it "It can find a spefic merchant based on id" do
    merchant_1 = create(:merchant)

    get "/api/v1/merchants/find?id=#{merchant_1.id}"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["id"]).to eq(merchant_1.id)
    expect(merchant["name"]).to eq(merchant_1.name)
  end

  it "It can find a spefic merchant based on name" do
    merchant_1 = create(:merchant)

    get "/api/v1/merchants/find?name=#{merchant_1.name}"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["name"]).to eq(merchant_1.name)
  end

  it "It can find all by name" do
    merchant_1 = create(:merchant, name: "Tom Hanks")
    merchant_2 = create(:merchant, name: "Tom Hanks")
    merchant_3 = create(:merchant, id: 12)

    get "/api/v1/merchants/find_all?name=#{merchant_1.name}"

    merchants = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchants.count).to eq(2)
    expect(merchants[0]["name"]).to eq(merchant_1.name)
    expect(merchants[1]["name"]).to eq(merchant_1.name)
  end

  it "It can find all by id" do
    merchant_1 = create(:merchant, name: "Tom Hanks")
    merchant_2 = create(:merchant, name: "Tom Hanks")
    merchant_3 = create(:merchant, id: 12)

    get "/api/v1/merchants/find_all?id=#{merchant_3.id}"

    merchants = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchants.count).to eq(1)
    expect(merchants[0]["id"]).to eq(merchant_3.id)
  end

  it "It can return a random merchant" do
    merchant_1 = create(:merchant, name: "Tim")
    merchant_2 = create(:merchant, name: "Nick")
    merchant_3 = create(:merchant, name: "Silver")

    get "/api/v1/merchants/random.json"

    random_merchant = JSON.parse(response.body)


    expect(response).to be_successful
    expect(random_merchant).to have_key("id")
    expect(random_merchant).to have_key("name")
    expect(random_merchant).to have_key("created_at")
    expect(random_merchant).to have_key("updated_at")
  end
end
