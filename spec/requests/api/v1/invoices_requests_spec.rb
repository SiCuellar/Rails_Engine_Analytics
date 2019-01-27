require 'rails_helper'

describe "Invoices API" do
  it " sends a list of invoices " do
    create_list(:invoice, 3)
    get "/api/v1/invoices"

    invoices = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoices["data"].count).to eq(3)
  end

  it "can show one specific invoice " do
    id = create(:invoice).id

    get "/api/v1/invoices/#{id}"
    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["data"]["id"].to_i).to eq(id)
  end

  it "It can find a spefic invoice based on id" do
    invoice_1 = create(:invoice)

    get "/api/v1/invoices/find?id=#{invoice_1.id}"

    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["data"]["id"].to_i).to eq(invoice_1.id)
    expect(invoice["data"]["attributes"]["status"]).to eq(invoice_1.status)
  end

  it "It can find a spefic invoice based on id" do
    invoice_1 = create(:invoice)
    invoice_2 = create(:invoice)

    get "/api/v1/invoices/find?id=#{invoice_1.id}"

    invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice["data"]["id"].to_i).to eq(invoice_1.id)
  end

  it "It can find all by inoives by status" do
    invoice_1 = create(:invoice, status: "shipping")
    invoice_2 = create(:invoice, status: "shipping")
    invoice_3 = create(:invoice, id: 12)

    get "/api/v1/invoices/find_all?status=#{invoice_1.status}"

    invoices = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoices["data"].count).to eq(2)
    expect(invoices["data"][0]["attributes"]["status"]).to eq(invoice_1.status)
  end

  it "It can find all by id" do
    invoice_1 = create(:invoice)
    invoice_2 = create(:invoice)
    invoice_3 = create(:invoice, id: 12)

    get "/api/v1/invoices/find_all?id=#{invoice_3.id}"

    invoices = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoices["data"].count).to eq(1)
    expect(invoices["data"][0]["id"].to_i).to eq(invoice_3.id)
  end

  it "It can return a random invoice" do
    invoice_1 = create(:invoice)
    invoice_2 = create(:invoice)
    invoice_3 = create(:invoice)

    get "/api/v1/invoices/random.json"

    random_invoice = JSON.parse(response.body)

    expect(response).to be_successful
    expect(random_invoice["data"]).to have_key("id")
    expect(random_invoice["data"]["attributes"]).to have_key("status")
  end
end
