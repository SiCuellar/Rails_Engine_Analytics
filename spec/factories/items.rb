FactoryBot.define do
  factory :item do
    name { "light saber" }
    description { "light sword that is very powerful" }
    unit_price { 5 }
    merchant { create(:merchant) }
  end
end
