FactoryBot.define do
  factory :invoice do
    status { "Pending" }
    customer { create(:customer) }
    merchant { create(:merchant) }
  end
end
