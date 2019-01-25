require 'rails_helper'

describe "Transactions API" do
  it " sends a list of transactions " do
    create_list(:transaction, 3)
    get "/api/v1/transactions"

    transactions = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transactions["data"].count).to eq(3)
  end

  it "can show one specific transaction " do
    id = create(:transaction).id

    get "/api/v1/transactions/#{id}"
    transaction = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transaction["data"]["id"].to_i).to eq(id)
  end
end
