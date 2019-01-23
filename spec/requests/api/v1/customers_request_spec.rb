require 'rails_helper'

describe "Customers API" do
  it "sends a lists of customers" do
    create_list(:customer, 3)

    get "/api/v1/customers"
    customers = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customers.count).to eq(3)
  end

  it "can show one specific customer " do
    id = create(:customer).id

    get "/api/v1/customers/#{id}"
    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["id"]).to eq(id)
  end
end
