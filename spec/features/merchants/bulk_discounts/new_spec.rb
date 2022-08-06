require 'rails_helper'

RSpec.describe 'merchant bulk discount new page' do
  describe '#new' do
    it 'has form to create a new bulk discount' do
      merchant_1 = Merchant.create!(name: 'Spongebob The Merchant')

      visit "/merchants/#{merchant_1.id}/bulk_discounts/new"

      expect(page).to have_content('New Bulk Discount')
      expect(find('form')).to have_content('Name')
      expect(find('form')).to have_content('Threshold')
      expect(find('form')).to have_content('Percent discount')
    end
  end

  describe '#create' do
    it 'when given valid data and click submit redirected to merchant bulk index page where new discount is displayed' do

      merchant_1 = Merchant.create!(name: 'Spongebob The Merchant')

      visit "/merchants/#{merchant_1.id}/bulk_discounts/new"

      fill_in 'Name', with: '12% off Dozen Burgers'
      fill_in 'Threshold', with: 12
      fill_in 'Percent discount', with: 12
      click_button 'Submit'

      expect(current_path).to eq("/merchants/#{merchant_1.id}/bulk_discounts")

      expect(page).to have_content('12% off Dozen Burgers Purchase of 12 items')
    end
  end
end