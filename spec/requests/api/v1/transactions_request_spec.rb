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

  it "It can find a spefic transaction based on id" do
    transaction_1 = create(:transaction)

    get "/api/v1/transactions/find?id=#{transaction_1.id}"

    transaction = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transaction["data"]["id"].to_i).to eq(transaction_1.id)
    expect(transaction["data"]["attributes"]["credit_card_number"]).to eq(transaction_1.credit_card_number)
  end

  it "It can find a spefic transaction based on id" do
    transaction_1 = create(:transaction)
    transaction_2 = create(:transaction)

    get "/api/v1/transactions/find?id=#{transaction_1.id}"

    transaction = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transaction["data"]["id"].to_i).to eq(transaction_1.id)
  end

  it "It can find all by inoives by result" do
    transaction_1 = create(:transaction, result: "shipping")
    transaction_2 = create(:transaction, result: "shipping")
    transaction_3 = create(:transaction, id: 12)

    get "/api/v1/transactions/find_all?result=#{transaction_1.result}"

    transactions = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transactions["data"].count).to eq(2)
    expect(transactions["data"][0]["attributes"]["result"]).to eq(transaction_1.result)
  end

  it "It can find all by id" do
    transaction_1 = create(:transaction)
    transaction_2 = create(:transaction)
    transaction_3 = create(:transaction, id: 12)

    get "/api/v1/transactions/find_all?id=#{transaction_3.id}"

    transactions = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transactions["data"].count).to eq(1)
    expect(transactions["data"][0]["id"].to_i).to eq(transaction_3.id)
  end

  it "It can return a random transaction" do
    transaction_1 = create(:transaction)
    transaction_2 = create(:transaction)
    transaction_3 = create(:transaction)

    get "/api/v1/transactions/random.json"

    random_transaction = JSON.parse(response.body)

    expect(response).to be_successful
    expect(random_transaction["data"]).to have_key("id")
    expect(random_transaction["data"]["attributes"]).to have_key("result")
  end
end
