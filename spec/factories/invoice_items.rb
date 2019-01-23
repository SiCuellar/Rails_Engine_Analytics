FactoryBot.define do
  factory :invoice_item do
    quantity { 1 }
    unit_price { 1 }
    item { create(:item) }
    invoice { create(:invoice) }
  end
end
