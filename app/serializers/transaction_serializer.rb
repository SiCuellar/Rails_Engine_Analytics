class TransactionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :credit_card_number, :result, :credit_card_expiration_date
end
