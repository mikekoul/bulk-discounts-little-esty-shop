class BulkDiscount < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :threshold
  validates_presence_of :percent_discount

  belongs_to :merchant
  has_many :items, through: :merchant
  has_many :invoice_items, through: :items
  has_many :invoices, through: :merchant
end