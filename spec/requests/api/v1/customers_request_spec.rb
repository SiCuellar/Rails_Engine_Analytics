require 'rails_helper'

describe "Customers API" do
  it "sends a lists of customers" do
    create_list(:customer, 3)

    get "/api/v1/customers"
    customers = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customers["data"].count).to eq(3)
  end

  it "can show one specific customer " do
    id = create(:customer).id

    get "/api/v1/customers/#{id}"
    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["data"]["id"].to_i).to eq(id)
  end

  it "It can find a spefic customer based on id" do
    customer_1 = create(:customer)

    get "/api/v1/customers/find?id=#{customer_1.id}"

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["data"]["id"].to_i).to eq(customer_1.id)
    expect(customer["data"]["attributes"]["first_name"]).to eq(customer_1.first_name)
    expect(customer["data"]["attributes"]["last_name"]).to eq(customer_1.last_name)
  end

  it "It can find a spefic customer based on name" do
    customer_1 = create(:customer)

    get "/api/v1/customers/find?name=#{customer_1.first_name}"

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["data"]["attributes"]["first_name"]).to eq(customer_1.first_name)
  end

  it "It can find all by first name" do
    customer_1 = create(:customer, first_name: "Silver")
    customer_2 = create(:customer, first_name: "Silver")
    customer_3 = create(:customer, id: 12)

    get "/api/v1/customers/find_all?first_name=#{customer_1.first_name}"

    customers = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customers["data"].count).to eq(2)
    expect(customers["data"][0]["attributes"]["first_name"]).to eq(customer_1.first_name)
    expect(customers["data"][1]["attributes"]["first_name"]).to eq(customer_1.first_name)
  end

  it "It can find all by last name" do
    customer_1 = create(:customer, last_name: "green")
    customer_2 = create(:customer, last_name: "green")
    customer_3 = create(:customer, id: 12)

    get "/api/v1/customers/find_all?last_name=#{customer_1.last_name}"

    customers = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customers["data"].count).to eq(2)
    expect(customers["data"][0]["attributes"]["last_name"]).to eq(customer_1.last_name)
    expect(customers["data"][1]["attributes"]["last_name"]).to eq(customer_1.last_name)
  end

  it "It can return a random customer" do
    customer_1 = create(:customer, first_name: "Tim")
    customer_2 = create(:customer, first_name: "Nick")
    customer_3 = create(:customer, first_name: "Silver")

    get "/api/v1/customers/random.json"

    random_customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(random_customer["data"]).to have_key("id")
    expect(random_customer["data"]["attributes"]).to have_key("first_name")
  end
end
