class Item < ApplicationRecord
  validates_presence_of :name,
                        :description,
                        :unit_price

  belongs_to :merchant
  has_many :invoice_items

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
end
