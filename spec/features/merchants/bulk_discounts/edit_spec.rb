require 'rails_helper'

RSpec.describe 'bulk discounts edit page' do
  describe "#edit" do
    it 'shows form with pre-loaded values' do
      merchant_1 = Merchant.create!(name: 'Spongebob The Merchant')
      discount_10 = BulkDiscount.create!(name: "10% off", threshold: 10, percent_discount: 10, merchant_id: merchant_1.id)

      visit "/merchants/#{merchant_1.id}/bulk_discounts/#{discount_10.id}/edit"

      expect(page).to have_field('Name', with: '10% off')
      expect(page).to have_field('Threshold', with: '10')
      expect
      (page).to have_field('Percent discount', with: '10')
    end

    it 'fill form in with valid values and redirect to show page with updated attributes' do
      merchant_1 = Merchant.create!(name: 'Spongebob The Merchant')
      discount_10 = BulkDiscount.create!(name: "10% off", threshold: 10, percent_discount: 10, merchant_id: merchant_1.id)

      visit "/merchants/#{merchant_1.id}/bulk_discounts/#{discount_10.id}/edit"

      fill_in 'Name', with: '15% off'
      fill_in 'Threshold', with: 20
      fill_in 'Percent discount', with: 15
      click_button 'Submit'

      expect(current_path).to eq("/merchants/#{merchant_1.id}/bulk_discounts/#{discount_10.id}")
      expect(page).to have_content('15% off Show Page')
      expect(page).to have_content('Quantity Threshold: 20 items')
      expect(page).to have_content('Percent Discount: 15%')
    end
  end
end