require 'rails_helper'

describe "InvoiceItems API" do
  it "sends a lists of InvoiceItems" do
    create_list(:invoice_item, 3)

    get "/api/v1/invoice_items"
    invoice_items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_items["data"].count).to eq(3)
  end

  it "can show one specific InvoiceItem " do
    id = create(:invoice_item).id

    get "/api/v1/invoice_items/#{id}"
    invoice_item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item["data"]["id"].to_i).to eq(id)
  end

  it "It can find all by invoiceitems by quantity" do
    invoice_item_1 = create(:invoice_item, quantity: "shipping")
    invoice_item_2 = create(:invoice_item, quantity: "shipping")
    invoice_item_3 = create(:invoice_item, id: 12)

    get "/api/v1/invoice_items/find_all?quantity=#{invoice_item_1.quantity}"

    invoices = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoices["data"].count).to eq(2)
    expect(invoices["data"][0]["attributes"]["quantity"]).to eq(invoice_item_1.quantity)
  end
end
