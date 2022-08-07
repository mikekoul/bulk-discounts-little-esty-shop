require 'rails_helper'

RSpec.describe Invoice do
  describe 'validations' do
    it { should validate_presence_of(:status) }
  end

  describe 'relationships' do
    it { should belong_to :customer }
    it { should have_many :transactions }
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
    it { should have_many(:bulk_discounts).through(:merchants) }
  end

  describe 'model methods' do
    it "#total_revenue" do
      merchant_1 = Merchant.create!(name: "Bobs Loggers")
      merchant_2 = Merchant.create!(name: "Roberts Loggings")
      item_1 = Item.create!(name: "Log", description: "Wood, maple", unit_price: 200, merchant_id: merchant_1.id )
      item_2 = Item.create!(name: "Saw", description: "Metal, sharp", unit_price: 300, merchant_id: merchant_1.id )
      item_3 = Item.create!(name: "Bench", description: "Cedar bench", unit_price: 400, merchant_id: merchant_1.id )
      item_4 = Item.create!(name: "Axe", description: "Big Axe", unit_price: 500, merchant_id: merchant_1.id )
      item_5 = Item.create!(name: "Hammer", description: "Carpenter's hammer, wood handle", unit_price: 600, merchant_id: merchant_2.id )
      item_6 = Item.create!(name: "Speed Square", description: "Metal w/ level", unit_price: 700, merchant_id: merchant_2.id )
      item_7 = Item.create!(name: "Mallet", description: "Wooden carpenter's mallet", unit_price: 800, merchant_id: merchant_2.id )
      item_8 = Item.create!(name: "Reciprocating Saw", description: "Electric reciprocating saw", unit_price: 900, merchant_id: merchant_2.id )

      customer_1 = Customer.create!(first_name: "David", last_name: "Smith")
      customer_2 = Customer.create!(first_name: "Cindy", last_name: "Lou")
      customer_3 = Customer.create!(first_name: "John", last_name: "Johnson")
      customer_4 = Customer.create!(first_name: "Mary", last_name: "Vale")

      invoice_1 = Invoice.create!(status: 0, customer_id: customer_1.id)
      invoice_2 = Invoice.create!(status: 0, customer_id: customer_2.id)
      invoice_3 = Invoice.create!(status: 2, customer_id: customer_3.id)
      invoice_4 = Invoice.create!(status: 2, customer_id: customer_4.id)
      invoice_5 = Invoice.create!(status: 0, customer_id: customer_4.id)

      invoice_item_1 = InvoiceItem.create!(quantity: 4, unit_price: 200, status: 0, item_id: item_1.id, invoice_id: invoice_1.id)
      invoice_item_2 = InvoiceItem.create!(quantity: 2, unit_price: 300, status: 1, item_id: item_2.id, invoice_id: invoice_1.id)
      invoice_item_3 = InvoiceItem.create!(quantity: 3, unit_price: 400, status: 2, item_id: item_3.id, invoice_id: invoice_2.id)
      invoice_item_4 = InvoiceItem.create!(quantity: 2, unit_price: 500, status: 1, item_id: item_4.id, invoice_id: invoice_2.id)
      invoice_item_5 = InvoiceItem.create!(quantity: 3, unit_price: 600, status: 2, item_id: item_5.id, invoice_id: invoice_3.id)
      invoice_item_6 = InvoiceItem.create!(quantity: 3, unit_price: 700, status: 0, item_id: item_6.id, invoice_id: invoice_3.id)
      invoice_item_7 = InvoiceItem.create!(quantity: 3, unit_price: 800, status: 2, item_id: item_7.id, invoice_id: invoice_4.id)
      invoice_item_8 = InvoiceItem.create!(quantity: 3, unit_price: 900, status: 2, item_id: item_8.id, invoice_id: invoice_4.id)
      invoice_item_9 = InvoiceItem.create!(quantity: 3, unit_price: 900, status: 1, item_id: item_8.id, invoice_id: invoice_5.id)
      invoice_item_10 = InvoiceItem.create!(quantity: 3, unit_price: 900, status: 1, item_id: item_8.id, invoice_id: invoice_5.id)

      expect(invoice_1.total_revenue).to eq(1400)
      expect(invoice_2.total_revenue).to eq(2200)
    end

    it "#incomplete_invoices" do
      merchant_1 = Merchant.create!(name: "Bobs Loggers")
      merchant_2 = Merchant.create!(name: "Roberts Loggings")
      item_1 = Item.create!(name: "Log", description: "Wood, maple", unit_price: 200, merchant_id: merchant_1.id )
      item_2 = Item.create!(name: "Saw", description: "Metal, sharp", unit_price: 300, merchant_id: merchant_1.id )
      item_3 = Item.create!(name: "Bench", description: "Cedar bench", unit_price: 400, merchant_id: merchant_1.id )
      item_4 = Item.create!(name: "Axe", description: "Big Axe", unit_price: 500, merchant_id: merchant_1.id )
      item_5 = Item.create!(name: "Hammer", description: "Carpenter's hammer, wood handle", unit_price: 600, merchant_id: merchant_2.id )
      item_6 = Item.create!(name: "Speed Square", description: "Metal w/ level", unit_price: 700, merchant_id: merchant_2.id )
      item_7 = Item.create!(name: "Mallet", description: "Wooden carpenter's mallet", unit_price: 800, merchant_id: merchant_2.id )
      item_8 = Item.create!(name: "Reciprocating Saw", description: "Electric reciprocating saw", unit_price: 900, merchant_id: merchant_2.id )

      customer_1 = Customer.create!(first_name: "David", last_name: "Smith")
      customer_2 = Customer.create!(first_name: "Cindy", last_name: "Lou")
      customer_3 = Customer.create!(first_name: "John", last_name: "Johnson")
      customer_4 = Customer.create!(first_name: "Mary", last_name: "Vale")

      invoice_1 = Invoice.create!(status: 0, customer_id: customer_1.id)
      invoice_2 = Invoice.create!(status: 0, customer_id: customer_2.id)
      invoice_3 = Invoice.create!(status: 2, customer_id: customer_3.id)
      invoice_4 = Invoice.create!(status: 2, customer_id: customer_4.id)
      invoice_5 = Invoice.create!(status: 0, customer_id: customer_4.id)

      invoice_item_1 = InvoiceItem.create!(quantity: 4, unit_price: 200, status: 0, item_id: item_1.id, invoice_id: invoice_1.id)
      invoice_item_2 = InvoiceItem.create!(quantity: 2, unit_price: 300, status: 1, item_id: item_2.id, invoice_id: invoice_1.id)
      invoice_item_3 = InvoiceItem.create!(quantity: 3, unit_price: 400, status: 2, item_id: item_3.id, invoice_id: invoice_2.id)
      invoice_item_4 = InvoiceItem.create!(quantity: 2, unit_price: 500, status: 1, item_id: item_4.id, invoice_id: invoice_2.id)
      invoice_item_5 = InvoiceItem.create!(quantity: 3, unit_price: 600, status: 2, item_id: item_5.id, invoice_id: invoice_3.id)
      invoice_item_6 = InvoiceItem.create!(quantity: 3, unit_price: 700, status: 0, item_id: item_6.id, invoice_id: invoice_3.id)
      invoice_item_7 = InvoiceItem.create!(quantity: 3, unit_price: 800, status: 2, item_id: item_7.id, invoice_id: invoice_4.id)
      invoice_item_8 = InvoiceItem.create!(quantity: 3, unit_price: 900, status: 2, item_id: item_8.id, invoice_id: invoice_4.id)
      invoice_item_9 = InvoiceItem.create!(quantity: 3, unit_price: 900, status: 1, item_id: item_8.id, invoice_id: invoice_5.id)
      invoice_item_10 = InvoiceItem.create!(quantity: 3, unit_price: 900, status: 1, item_id: item_8.id, invoice_id: invoice_5.id)

      expect(Invoice.incomplete_invoices.count).to eq(4)
      expect(Invoice.incomplete_invoices).to eq([invoice_1, invoice_2, invoice_3, invoice_5])
    end
  end

  describe "#applied discounts" do
    it "calulates 10% off 10 items" do
      merchant_1 = Merchant.create!(name: "Bobs Loggers")

      item_1 = Item.create!(name: "Log", description: "Wood, maple", unit_price: 200, merchant_id: merchant_1.id )
      customer_1 = Customer.create!(first_name: "David", last_name: "Smith")

      invoice_1 = Invoice.create!(status: 0, customer_id: customer_1.id)

      invoice_item_1 = InvoiceItem.create!(quantity: 10, unit_price: 200, status: 0, item_id: 
      item_1.id, invoice_id: invoice_1.id)

      discount_10 = BulkDiscount.create!(name: "10% off", threshold: 10, percent_discount: 10, merchant_id: merchant_1.id)
      discount_20 = BulkDiscount.create!(name: "20% off", threshold: 20, percent_discount: 20, merchant_id: merchant_1.id)
      discount_30 = BulkDiscount.create!(name: "30% off", threshold: 30, percent_discount: 30, merchant_id: merchant_1.id)

      expect(invoice_1.discount_amount).to eq(200)
    end

    it "if invoice item does not meet discount item threshold no dicount is applied" do
      merchant_1 = Merchant.create!(name: "Bobs Loggers")

      item_1 = Item.create!(name: "Log", description: "Wood, maple", unit_price: 200, merchant_id: merchant_1.id )
      customer_1 = Customer.create!(first_name: "David", last_name: "Smith")

      invoice_1 = Invoice.create!(status: 0, customer_id: customer_1.id)

      invoice_item_1 = InvoiceItem.create!(quantity: 9, unit_price: 200, status: 0, item_id: 
      item_1.id, invoice_id: invoice_1.id)

      discount_10 = BulkDiscount.create!(name: "10% off", threshold: 10, percent_discount: 10, merchant_id: merchant_1.id)
      discount_20 = BulkDiscount.create!(name: "20% off", threshold: 20, percent_discount: 20, merchant_id: merchant_1.id)
      discount_30 = BulkDiscount.create!(name: "30% off", threshold: 30, percent_discount: 30, merchant_id: merchant_1.id)

      expect(invoice_1.discount_amount).to eq(0)
    end

    it "20% off 25 items for item 2, item_1 does not reach threshold so therefore does not recieve discount" do
      merchant_1 = Merchant.create!(name: "Bobs Loggers")

      item_1 = Item.create!(name: "Log", description: "Wood, maple", unit_price: 200, merchant_id: merchant_1.id )
      item_2 = Item.create!(name: "Saw", description: "Metal, sharp", unit_price: 400, merchant_id: merchant_1.id )
      customer_1 = Customer.create!(first_name: "David", last_name: "Smith")

      invoice_1 = Invoice.create!(status: 0, customer_id: customer_1.id)

      invoice_item_1 = InvoiceItem.create!(quantity: 9, unit_price: 200, status: 0, item_id: 
      item_1.id, invoice_id: invoice_1.id)
      invoice_item_2 = InvoiceItem.create!(quantity: 25, unit_price: 400, status: 0, item_id: 
      item_2.id, invoice_id: invoice_1.id)

      discount_10 = BulkDiscount.create!(name: "10% off", threshold: 10, percent_discount: 10, merchant_id: merchant_1.id)
      discount_20 = BulkDiscount.create!(name: "20% off", threshold: 20, percent_discount: 20, merchant_id: merchant_1.id)

      expect(invoice_1.discount_amount).to eq(2000)
    end

    it "item_1 and item_2 do reach threshold so their discounts added together " do
      merchant_1 = Merchant.create!(name: "Bobs Loggers")

      item_1 = Item.create!(name: "Log", description: "Wood, maple", unit_price: 200, merchant_id: merchant_1.id )
      item_2 = Item.create!(name: "Saw", description: "Metal, sharp", unit_price: 400, merchant_id: merchant_1.id )
      customer_1 = Customer.create!(first_name: "David", last_name: "Smith")

      invoice_1 = Invoice.create!(status: 0, customer_id: customer_1.id)

      invoice_item_1 = InvoiceItem.create!(quantity: 10, unit_price: 200, status: 0, item_id: 
      item_1.id, invoice_id: invoice_1.id)
      invoice_item_2 = InvoiceItem.create!(quantity: 25, unit_price: 400, status: 0, item_id: 
      item_2.id, invoice_id: invoice_1.id)

      discount_10 = BulkDiscount.create!(name: "10% off", threshold: 10, percent_discount: 10, merchant_id: merchant_1.id)
      discount_20 = BulkDiscount.create!(name: "20% off", threshold: 20, percent_discount: 20, merchant_id: merchant_1.id)

      expect(invoice_1.discount_amount).to eq(2200)
    end

    it "item_1 and item_2 do not reach threshold so discount is zero, different items dont recieve discount, though the total quantity of both items reaches threshold" do
      merchant_1 = Merchant.create!(name: "Bobs Loggers")

      item_1 = Item.create!(name: "Log", description: "Wood, maple", unit_price: 200, merchant_id: merchant_1.id )
      item_2 = Item.create!(name: "Saw", description: "Metal, sharp", unit_price: 400, merchant_id: merchant_1.id )
      customer_1 = Customer.create!(first_name: "David", last_name: "Smith")

      invoice_1 = Invoice.create!(status: 0, customer_id: customer_1.id)

      invoice_item_1 = InvoiceItem.create!(quantity: 5, unit_price: 200, status: 0, item_id: 
      item_1.id, invoice_id: invoice_1.id)
      invoice_item_2 = InvoiceItem.create!(quantity: 5, unit_price: 400, status: 0, item_id: 
      item_2.id, invoice_id: invoice_1.id)

      discount_10 = BulkDiscount.create!(name: "10% off", threshold: 10, percent_discount: 10, merchant_id: merchant_1.id)
      discount_20 = BulkDiscount.create!(name: "20% off", threshold: 20, percent_discount: 20, merchant_id: merchant_1.id)

      expect(invoice_1.discount_amount).to eq(0)
    end

    it "item_1 and item_2 reach two discount thresholds but only the max discount is applied" do
      merchant_1 = Merchant.create!(name: "Bobs Loggers")

      item_1 = Item.create!(name: "Log", description: "Wood, maple", unit_price: 200, merchant_id: merchant_1.id )
      item_2 = Item.create!(name: "Saw", description: "Metal, sharp", unit_price: 400, merchant_id: merchant_1.id )
      customer_1 = Customer.create!(first_name: "David", last_name: "Smith")

      invoice_1 = Invoice.create!(status: 0, customer_id: customer_1.id)

      invoice_item_1 = InvoiceItem.create!(quantity: 21, unit_price: 200, status: 0, item_id: 
      item_1.id, invoice_id: invoice_1.id)
      invoice_item_2 = InvoiceItem.create!(quantity: 22, unit_price: 400, status: 0, item_id: 
      item_2.id, invoice_id: invoice_1.id)

      discount_10 = BulkDiscount.create!(name: "10% off", threshold: 10, percent_discount: 10, merchant_id: merchant_1.id)
      discount_20 = BulkDiscount.create!(name: "20% off", threshold: 20, percent_discount: 20, merchant_id: merchant_1.id)

      expect(invoice_1.discount_amount).to eq(2600)
    end

    it "item_1 and item_2 belong to merchant_1 and reach threshold so recieve discount, item_3 belongs to merchant_2 who has  no bulk discounts and no discount is applied" do
      merchant_1 = Merchant.create!(name: "Bobs Loggers")
      merchant_2 = Merchant.create!(name: 'Spongebob The Merchant')

      item_1 = Item.create!(name: "Log", description: "Wood, maple", unit_price: 200, merchant_id: merchant_1.id )
      item_2 = Item.create!(name: "Saw", description: "Metal, sharp", unit_price: 400, merchant_id: merchant_1.id )
      item_3 = Item.create!(name: "Bench", description: "Cedar bench", unit_price: 150, merchant_id: merchant_2.id )

      customer_1 = Customer.create!(first_name: "David", last_name: "Smith")

      invoice_1 = Invoice.create!(status: 0, customer_id: customer_1.id)

      invoice_item_1 = InvoiceItem.create!(quantity: 12, unit_price: 200, status: 0, item_id: 
      item_1.id, invoice_id: invoice_1.id)
      invoice_item_2 = InvoiceItem.create!(quantity: 15, unit_price: 400, status: 0, item_id: 
      item_2.id, invoice_id: invoice_1.id)
      invoice_item_2 = InvoiceItem.create!(quantity: 15, unit_price: 1000, status: 0, item_id: 
      item_3.id, invoice_id: invoice_1.id)

      discount_10 = BulkDiscount.create!(name: "10% off", threshold: 10, percent_discount: 10, merchant_id: merchant_1.id)
      discount_20 = BulkDiscount.create!(name: "20% off", threshold: 20, percent_discount: 20, merchant_id: merchant_1.id)

      expect(invoice_1.discount_amount).to eq(840)
    end
  end
end
