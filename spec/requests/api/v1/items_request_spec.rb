require 'rails_helper'

describe "Items API" do
  it "sends a list of items" do
    create_list(:item, 3)

    get "/api/v1/items"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"].count).to eq(3)
  end

  it "can show one specific item" do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["data"]["id"].to_i).to eq(id)
  end

  it "It can find a spefic item based on id" do
    item_1 = create(:item)

    get "/api/v1/items/find?id=#{item_1.id}"

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["data"]["id"].to_i).to eq(item_1.id)
    expect(item["data"]["attributes"]["name"]).to eq(item_1.name)
  end

  it "It can find a spefic item based on name" do
    item_1 = create(:item)

    get "/api/v1/items/find?name=#{item_1.name}"

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["data"]["attributes"]["name"]).to eq(item_1.name)
  end

  it "It can find all by name" do
    item_1 = create(:item, name: "Tom Hanks")
    item_2 = create(:item, name: "Tom Hanks")
    item_3 = create(:item, id: 12)

    get "/api/v1/items/find_all?name=#{item_1.name}"

    items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(items["data"].count).to eq(2)
    expect(items["data"][0]["attributes"]["name"]).to eq(item_1.name)
    expect(items["data"][1]["attributes"]["name"]).to eq(item_1.name)
  end

  it "It can find all by id" do
    item_1 = create(:item, name: "Tom Hanks")
    item_2 = create(:item, name: "Tom Hanks")
    item_3 = create(:item, id: 12)

    get "/api/v1/items/find_all?id=#{item_3.id}"

    items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(items["data"].count).to eq(1)
    expect(items["data"][0]["id"].to_i).to eq(item_3.id)
  end

  it "It can return a random item" do
    item_1 = create(:item, name: "Tim")
    item_2 = create(:item, name: "Nick")
    item_3 = create(:item, name: "Silver")

    get "/api/v1/items/random.json"

    random_item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(random_item["data"]).to have_key("id")
    expect(random_item["data"]["attributes"]).to have_key("name")
  end
end
