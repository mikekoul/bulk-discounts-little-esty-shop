require 'rails_helper'

RSpec.describe 'bulk discounts index page' do
  describe '#index' do
    it 'display attributes of merchant bulk discounts' do
      merchant_1 = Merchant.create!(name: 'Spongebob The Merchant')
      merchant_2 = Merchant.create!(name: 'Sandy The Squirrel Merchant')
      discount_10 = BulkDiscount.create!(name: "10% off", threshold: 10, percent_off: 10, merchant_id: merchant_1.id)
      discount_20 = BulkDiscount.create!(name: "20% off", threshold: 20, percent_off: 20, merchant_id: merchant_1.id)
      discount_30 = BulkDiscount.create!(name: "30% off", threshold: 30, percent_off: 30, merchant_id: merchant_1.id)
      special_discount_10 = BulkDiscount.create!(name: "Special 10% off", threshold: 10, percent_off: 10, merchant_id: merchant_2.id)

      visit "/merchants/#{merchant_1.id}/bulk_discounts"

      expect(page).to have_content('Spongebob The Merchant')
      expect(page).to_not have_content('Sandy The Squirrel Merchant')

      within "#discounts-#{discount_10.id}" do
        expect(page).to have_content("10% off Purchase of 10 items")
        expect(page).to_not have_content("Special 10% off Purchase of 10 items")
      end

      within "#discounts-#{discount_20.id}" do
        expect(page).to have_content("20% off Purchase of 20 items")
        expect(page).to_not have_content("10% off Purchase of 10 items")
      end

      within "#discounts-#{discount_30.id}" do
        expect(page).to have_content("30% off Purchase of 30 items")
        expect(page).to_not have_content("20% off Purchase of 20 items")
      end
    end
  end
end