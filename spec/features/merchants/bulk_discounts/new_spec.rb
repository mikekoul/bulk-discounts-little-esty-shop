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
    it ''
  end
end