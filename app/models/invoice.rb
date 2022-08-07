class Invoice < ApplicationRecord
  validates_presence_of :status

  belongs_to :customer
  has_many :transactions, dependent: :destroy
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :bulk_discounts, through: :merchants

  enum status: { "in progress" => 0, "cancelled" => 1, "completed" => 2 }

  def self.incomplete_invoices
    joins(:invoice_items)
    .where.not(invoice_items: { status: 2 })
    .order(:created_at)
    .distinct
  end

  def total_revenue
   invoice_items.sum("unit_price * quantity")
  end

  def discount_amount
    invoice_items.joins(:bulk_discounts)
    .select("invoice_items.id, max(invoice_items.unit_price * invoice_items.quantity * (bulk_discounts.percent_discount / 100.00)) as discount")
    .where("invoice_items.quantity >= bulk_discounts.threshold")
    .group("invoice_items.id")
    .sum(&:discount)
  end
end
