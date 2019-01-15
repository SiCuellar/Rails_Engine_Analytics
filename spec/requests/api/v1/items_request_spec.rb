require 'rails_helper'

describe "Items API" do
  it "sends a list of items" do
    create_list(:item, 3)

    get "/api/v1/items"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items.count).to eq(3)
  end

  it "can show one specific item" do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["id"]).to eq(id)
  end

  it "can create an item" do
	  item_params = { name: "Saw", description: "I want to play a game"}

	  post "/api/v1/items" , params: {item: item_params}
	  item = Item.last 

	  assert_response :success 
	  expect(response).to be_successful
	  expect(item.name).to eq(item_params[:name])
  end
end
