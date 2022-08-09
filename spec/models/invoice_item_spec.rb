require 'rails_helper'

RSpec.describe InvoiceItem do
  describe 'validations' do
    it { should validate_presence_of(:quantity)}
    it { should validate_presence_of(:unit_price)}
    it { should validate_presence_of(:status)}
  end

  describe 'relationships' do
    it { should belong_to :item }
    it { should belong_to :invoice }
    it { should have_many(:bulk_discounts).through(:item) }
  end

  describe "#methods" do
    it 'returns 10% off applied discount to the invoice item' do

      merchant_1 = Merchant.create!(name: "Bobs Loggers")
      item_1 = Item.create!(name: "Log", description: "Wood, maple", unit_price: 100, merchant_id: merchant_1.id )
      customer_1 = Customer.create!(first_name: "David", last_name: "Smith")
      invoice_1 = Invoice.create!(status: 0, customer_id: customer_1.id)
      invoice_item_1 = InvoiceItem.create!(quantity: 12, unit_price: 100, status: 0, item_id: item_1.id, invoice_id: invoice_1.id)
      discount_10 = BulkDiscount.create!(name: "10% off", threshold: 10, percent_discount: 10, merchant_id: merchant_1.id)
      discount_20 = BulkDiscount.create!(name: "20% off", threshold: 20, percent_discount: 20, merchant_id: merchant_1.id)
      discount_30 = BulkDiscount.create!(name: "30% off", threshold: 30, percent_discount: 30, merchant_id: merchant_1.id)

      expect(invoice_item.discount_applied).to eq(discount_10)
    end
    end
  end
end