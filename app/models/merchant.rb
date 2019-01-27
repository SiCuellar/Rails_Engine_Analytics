class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

  def self.top_merchants_revenue(number)
    joins(:invoices, :invoice_items)
    .group(:id)
    .order("sum(quantity * unit_price) desc")
    .limit(number)
  end

  def self.top_merchants_items_sold(number)
    joins(:invoices, :invoice_items)
    .group(:id)
    .order("sum(quantity) desc")
    .limit(number)
  end

  def self.total_revenue_by_date(date)
    joins(:invoices, :invoice_items)
    .where(invoice_items: {created_at: date})
    .sum("quantity * unit_price")
  end

  # def total_rev_success
  #   x = Merchant.joins(:transactions)
  #   .where(transactions: {result: "successful"})
  #
  #   binding.pry
  #   # .sum("quantity * unit_price")
  # end
end
