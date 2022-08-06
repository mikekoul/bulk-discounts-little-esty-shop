require 'rails_helper'

RSpec.describe 'bulk discounts show page' do
  describe "#show" do
    it 'displays atrributes of bulk discount' do
      merchant_1 = Merchant.create!(name: 'Spongebob The Merchant')
      merchant_2 = Merchant.create!(name: 'Sandy The Squirrel Merchant')
      discount_10 = BulkDiscount.create!(name: "10% off", threshold: 10, percent_discount: 10, merchant_id: merchant_1.id)
      discount_20 = BulkDiscount.create!(name: "20% off", threshold: 20, percent_discount: 20, merchant_id: merchant_1.id)

      visit "merchants/#{merchant_1.id}/bulk_discounts/#{discount_10.id}"

      expect(page).to have_content('10% off Show Page')
      expect(page).to have_content('Quantity Threshold: 10 items')
      expect(page).to have_content('Percent Discount: 10%')
      expect(page).to_not have_content('Quantity Threshold: 20 items')
      expect(page).to_not have_content('Percent Discount: 20%')
      expect(page).to_not have_content('20% off Show Page')
    end
  end
end