require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:name)}
  end

  describe 'Relationships' do
    it { should have_many(:items)}
    it { should have_many(:invoices)}
    it { should have_many(:invoice_items).through(:invoices)}
  end

  describe "merchant Business intel" do
    it "#top_merchants_revenue" do
      customer = create(:customer)

      merchant_1 = create(:merchant, name: "top")
      merchant_2 = create(:merchant, name: "second")
      merchant_3 = create(:merchant, name: "last")

      item_1 = create(:item, merchant_id: merchant_1.id)
      item_2 = create(:item, merchant_id: merchant_2.id)
      item_3 = create(:item, merchant_id: merchant_3.id)

      invoice_1 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer.id)
      invoice_2 = create(:invoice, merchant_id: merchant_2.id, customer_id: customer.id)
      invoice_3 = create(:invoice, merchant_id: merchant_3.id, customer_id: customer.id)

      invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id, quantity: 3, unit_price: 20)
      invoice_item_2 = create(:invoice_item, item_id: item_2.id, invoice_id: invoice_2.id, quantity: 2, unit_price: 20)
      invoice_item_3 = create(:invoice_item, item_id: item_3.id, invoice_id: invoice_3.id, quantity: 1, unit_price: 20)

      top_merch = Merchant.top_merchants_revenue(2)

      expect(top_merch[0].name).to eq("top")
      expect(top_merch[1].name).to eq("second")
      expect(top_merch.length).to eq(2)
    end

    it "#top_merchants_items_sold" do
      customer = create(:customer)

      merchant_1 = create(:merchant, name: "top")
      merchant_2 = create(:merchant, name: "second")
      merchant_3 = create(:merchant, name: "last")

      item_1 = create(:item, merchant_id: merchant_1.id)
      item_2 = create(:item, merchant_id: merchant_2.id)
      item_3 = create(:item, merchant_id: merchant_3.id)

      invoice_1 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer.id)
      invoice_2 = create(:invoice, merchant_id: merchant_2.id, customer_id: customer.id)
      invoice_3 = create(:invoice, merchant_id: merchant_3.id, customer_id: customer.id)

      invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id, quantity: 50)
      invoice_item_2 = create(:invoice_item, item_id: item_2.id, invoice_id: invoice_2.id, quantity: 20)
      invoice_item_3 = create(:invoice_item, item_id: item_3.id, invoice_id: invoice_3.id, quantity: 10)

      top_merchants_items_sold = Merchant.top_merchants_items_sold(2)

      expect(top_merchants_items_sold[0].name).to eq("top")
      expect(top_merchants_items_sold[1].name).to eq("second")
      expect(top_merchants_items_sold.length).to eq(2)
    end

    it "#total_revenue_by_date" do
      customer = create(:customer)

      merchant_1 = create(:merchant, name: "top")
      merchant_2 = create(:merchant, name: "second")
      merchant_3 = create(:merchant, name: "last")

      item_1 = create(:item, merchant_id: merchant_1.id)
      item_2 = create(:item, merchant_id: merchant_2.id)
      item_3 = create(:item, merchant_id: merchant_3.id)

      invoice_1 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer.id)
      invoice_2 = create(:invoice, merchant_id: merchant_2.id, customer_id: customer.id)
      invoice_3 = create(:invoice, merchant_id: merchant_3.id, customer_id: customer.id)

      invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id, quantity: 5, unit_price: 1, created_at: "2012-03-27 14:54:09 UTC")
      invoice_item_2 = create(:invoice_item, item_id: item_2.id, invoice_id: invoice_2.id, quantity: 2, unit_price: 1, created_at: "2012-03-27 14:54:09 UTC")
      invoice_item_3 = create(:invoice_item, item_id: item_3.id, invoice_id: invoice_3.id, quantity: 10, unit_price: 20, created_at: "2015-01-27 14:54:09 UTC")

      total_rev = Merchant.total_revenue_by_date("2012-03-27 14:54:09 UTC")

      expect(total_rev).to eq(7)

    end
  end
end
