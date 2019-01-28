class Item < ApplicationRecord
  validates_presence_of :name,
                        :description,
                        :unit_price

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.top_item_revenue(number)
    joins(:invoice_items)
    .group(:id)
    .order("sum(invoice_items.quantity * invoice_items.unit_price) desc")
    .limit(number)
  end

  def self.top_item_sold_quant(number)
    joins(:invoice_items)
    .group(:id)
    .order("sum(invoice_items.quantity) desc")
    .limit(number)
  end

  def best_date
    Invoice.select("invoices.created_at, sum(invoice_items.quantity) AS best_day")
    .joins(:invoice_items)
    .where("invoice_items.item_id = item_id")
    .group(:id)
    .order("best_day desc, invoices.created_at desc")
    .limit(1)
    .first.created_at
  end
end
