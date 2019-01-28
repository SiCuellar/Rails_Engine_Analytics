require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:name)}
    it { should validate_presence_of(:description)}
    it { should validate_presence_of(:unit_price)}
  end

  describe 'Relationships' do
    it {should belong_to(:merchant)}
    it {should have_many(:invoice_items)}
  end

  describe "item business intel " do
    it "#top_item_revenue" do
      customer = create(:customer)

      merchant_1 = create(:merchant)

      item_1 = create(:item, merchant_id: merchant_1.id, name: "top")
      item_2 = create(:item, merchant_id: merchant_1.id, name: "mid")
      item_3 = create(:item, merchant_id: merchant_1.id, name: "fail")

      invoice_1 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer.id)
      invoice_2 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer.id)
      invoice_3 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer.id)

      invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id, quantity: 3, unit_price: 20)
      invoice_item_2 = create(:invoice_item, item_id: item_2.id, invoice_id: invoice_2.id, quantity: 2, unit_price: 20)
      invoice_item_3 = create(:invoice_item, item_id: item_3.id, invoice_id: invoice_3.id, quantity: 1, unit_price: 20)

      top_item = Item.top_item_revenue(2)

      expect(top_item[0].name).to eq("top")
      expect(top_item[1].name).to eq("mid")
      expect(top_item.length).to eq(2)
    end

    it "#top_item_sold_quant" do
      customer = create(:customer)

      merchant_1 = create(:merchant)

      item_1 = create(:item, merchant_id: merchant_1.id, name: "top")
      item_2 = create(:item, merchant_id: merchant_1.id, name: "mid")
      item_3 = create(:item, merchant_id: merchant_1.id, name: "fail")

      invoice_1 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer.id)
      invoice_2 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer.id)
      invoice_3 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer.id)

      invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id, quantity: 50, unit_price: 20)
      invoice_item_2 = create(:invoice_item, item_id: item_2.id, invoice_id: invoice_2.id, quantity: 30, unit_price: 20)
      invoice_item_3 = create(:invoice_item, item_id: item_3.id, invoice_id: invoice_3.id, quantity: 20, unit_price: 20)

      top_items = Item.top_item_sold_quant(2)

      expect(top_items[0].name).to eq("top")
      expect(top_items[1].name).to eq("mid")
      expect(top_items.length).to eq(2)
    end

    it ".best_date" do
      customer = create(:customer)

      merchant_1 = create(:merchant)

      item_1 = create(:item, merchant_id: merchant_1.id, name: "top")

      invoice_1 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer.id, created_at: "2012-03-27 14:54:09 UTC")
      invoice_2 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer.id, created_at: "2012-03-27 14:54:09 UTC")
      invoice_3 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer.id, created_at: "2015-03-27 14:54:09 UTC")

      invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id, quantity: 5, unit_price: 20, created_at: "2012-03-27 14:54:09 UTC")
      invoice_item_2 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_2.id, quantity: 2, unit_price: 20, created_at: "2012-03-27 14:54:09 UTC")
      invoice_item_3 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_3.id, quantity: 1, unit_price: 20, created_at: "2015-03-27 14:54:09 UTC")

      best_item_day = item_1.best_date

      expect(best_item_day).to eq("2012-03-27 14:54:09 UTC")
    end
  end
end
