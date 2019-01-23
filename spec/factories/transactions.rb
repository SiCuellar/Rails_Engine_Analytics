FactoryBot.define do
  factory :transaction do
    credit_card_number { "12345678910" }
    result { "pending" }
    credit_card_expiration_date { "2019-01-23 15:49:35" }
  end
end
