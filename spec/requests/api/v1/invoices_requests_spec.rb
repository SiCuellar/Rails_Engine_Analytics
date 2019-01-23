require 'rails_helper'

describe "Invoices API" do
  it " sends a list of invoices " do
    create_list(:invoice, 3)
    get "/api/v1/invoices"

    invoices = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoices.count).to eq(3)
  end

  it "can show one specific invoice " do
    id = create(:invoice).id

    get "/api/v1/invoices/#{id}"
    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["id"]).to eq(id)
  end
end
