require 'csv'

namespace :import do

  desc "Import ALL CSV DATA"
  task data: :environment do
    Rake::Task["import:destroyer"].invoke
    Rake::Task["import:customers"].invoke
    Rake::Task["import:merchants"].invoke
    Rake::Task["import:items"].invoke
    Rake::Task["import:invoices"].invoke
    Rake::Task["import:invoice_items"].invoke
    Rake::Task["import:transactions"].invoke
  end

  desc "Destroy All Tables"
  task destroyer: :environment do
    Transaction.destroy_all
    InvoiceItem.destroy_all
    Invoice.destroy_all
    Item.destroy_all
    Customer.destroy_all
    Merchant.destroy_all
  end

  desc "Import Customers from CSV"
  task customers: :environment do
    file_path = "./db/data/customers.csv"
    CSV.foreach(file_path, headers: true) do |row|
      Customer.create!(row.to_h)
    end
  end

  desc "Import InvoiceItems from CSV"
  task invoice_items: :environment do
    file_path = "./db/data/invoice_items.csv"
    CSV.foreach(file_path, headers: true) do |row|
      InvoiceItem.create!(row.to_h)
    end
  end

  desc "Import invoices from CSV"
  task invoices: :environment do
    file_path = "./db/data/invoices.csv"
    CSV.foreach(file_path, headers: true) do |row|
    Invoice.create!(row.to_h)
    end
  end

  desc "Import Items from CSV"
  task items: :environment do
    file_path = "./db/data/items.csv"
    CSV.foreach(file_path, headers: true) do |row|
      Item.create!(row.to_h)
    end
  end

  desc "Import merchants from CSV"
  task merchants: :environment do
    file_path = "./db/data/merchants.csv"
    CSV.foreach(file_path, headers: true) do |row|
      Merchant.create!(row.to_h)
    end
  end

  desc "Import transactions from CSV"
  task transactions: :environment do
    file_path = "./db/data/transactions.csv"
    CSV.foreach(file_path, headers: true) do |row|
      Transaction.create!(row.to_h)
    end
  end
end
