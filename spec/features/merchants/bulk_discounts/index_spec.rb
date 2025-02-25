require 'rails_helper'

RSpec.describe 'bulk discounts index page' do
  describe '#index' do
    it 'display attributes of merchant bulk discounts' do
      merchant_1 = Merchant.create!(name: 'Spongebob The Merchant')
      merchant_2 = Merchant.create!(name: 'Sandy The Squirrel Merchant')
      discount_10 = BulkDiscount.create!(name: "10% off", threshold: 10, percent_discount: 10, merchant_id: merchant_1.id)
      discount_20 = BulkDiscount.create!(name: "20% off", threshold: 20, percent_discount: 20, merchant_id: merchant_1.id)
      discount_30 = BulkDiscount.create!(name: "30% off", threshold: 30, percent_discount: 30, merchant_id: merchant_1.id)
      special_discount_10 = BulkDiscount.create!(name: "Special 10% off", threshold: 10, percent_discount: 10, merchant_id: merchant_2.id)

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

    it 'each bulk discount has a link to its show page' do
      merchant_1 = Merchant.create!(name: 'Spongebob The Merchant')
      merchant_2 = Merchant.create!(name: 'Sandy The Squirrel Merchant')
      discount_10 = BulkDiscount.create!(name: "10% off", threshold: 10, percent_discount: 10, merchant_id: merchant_1.id)
      discount_20 = BulkDiscount.create!(name: "20% off", threshold: 20, percent_discount: 20, merchant_id: merchant_1.id)
      discount_30 = BulkDiscount.create!(name: "30% off", threshold: 30, percent_discount: 30, merchant_id: merchant_1.id)
      special_discount_10 = BulkDiscount.create!(name: "Special 10% off", threshold: 10, percent_discount: 10, merchant_id: merchant_2.id)

      visit "/merchants/#{merchant_1.id}/bulk_discounts"

      within "#discounts-#{discount_10.id}" do
        expect(page).to have_link("10% off Info Page")
      end

      within "#discounts-#{discount_20.id}" do
        expect(page).to have_link("20% off Info Page")
      end

      within "#discounts-#{discount_30.id}" do
        expect(page).to have_link("30% off Info Page")
      end
    end
  end

  describe "#new" do
    it 'page contains link to create a new bulk discount' do
      merchant_1 = Merchant.create!(name: 'Spongebob The Merchant')
      merchant_2 = Merchant.create!(name: 'Sandy The Squirrel Merchant')
      discount_10 = BulkDiscount.create!(name: "10% off", threshold: 10, percent_discount: 10, merchant_id: merchant_1.id)
      discount_20 = BulkDiscount.create!(name: "20% off", threshold: 20, percent_discount: 20, merchant_id: merchant_1.id)
      discount_30 = BulkDiscount.create!(name: "30% off", threshold: 30, percent_discount: 30, merchant_id: merchant_1.id)
      special_discount_10 = BulkDiscount.create!(name: "Special 10% off", threshold: 10, percent_discount: 10, merchant_id: merchant_2.id)

      visit "/merchants/#{merchant_1.id}/bulk_discounts"

      expect(page).to have_link("Create New Discount")
    end
    
    it 'click link to create a new discount and redirect to new page' do
      merchant_1 = Merchant.create!(name: 'Spongebob The Merchant')
      merchant_2 = Merchant.create!(name: 'Sandy The Squirrel Merchant')
      discount_10 = BulkDiscount.create!(name: "10% off", threshold: 10, percent_discount: 10, merchant_id: merchant_1.id)
      discount_20 = BulkDiscount.create!(name: "20% off", threshold: 20, percent_discount: 20, merchant_id: merchant_1.id)
      discount_30 = BulkDiscount.create!(name: "30% off", threshold: 30, percent_discount: 30, merchant_id: merchant_1.id)
      special_discount_10 = BulkDiscount.create!(name: "Special 10% off", threshold: 10, percent_discount: 10, merchant_id: merchant_2.id)

      visit "/merchants/#{merchant_1.id}/bulk_discounts"

      click_link("Create New Discount")

      expect(current_path).to eq("/merchants/#{merchant_1.id}/bulk_discounts/new")
    end
  end

  describe "#delete" do
    it 'next to each bulk discount is a button to delete it' do
      merchant_1 = Merchant.create!(name: 'Spongebob The Merchant')
      merchant_2 = Merchant.create!(name: 'Sandy The Squirrel Merchant')
      discount_10 = BulkDiscount.create!(name: "10% off", threshold: 10, percent_discount: 10, merchant_id: merchant_1.id)
      discount_20 = BulkDiscount.create!(name: "20% off", threshold: 20, percent_discount: 20, merchant_id: merchant_1.id)
      discount_30 = BulkDiscount.create!(name: "30% off", threshold: 30, percent_discount: 30, merchant_id: merchant_1.id)
      special_discount_10 = BulkDiscount.create!(name: "Special 10% off", threshold: 10, percent_discount: 10, merchant_id: merchant_2.id)

      visit "/merchants/#{merchant_1.id}/bulk_discounts"

      within "#discounts-#{discount_10.id}" do
        expect(page).to have_button('Delete')
      end

      within "#discounts-#{discount_20.id}" do
        expect(page).to have_button('Delete')
      end

      within "#discounts-#{discount_30.id}" do
        expect(page).to have_button('Delete')
      end
    end

    it 'click delete and redirected to page where discount is no longer there' do
      merchant_1 = Merchant.create!(name: 'Spongebob The Merchant')
      merchant_2 = Merchant.create!(name: 'Sandy The Squirrel Merchant')
      discount_10 = BulkDiscount.create!(name: "10% off", threshold: 10, percent_discount: 10, merchant_id: merchant_1.id)
      discount_20 = BulkDiscount.create!(name: "20% off", threshold: 20, percent_discount: 20, merchant_id: merchant_1.id)
      discount_30 = BulkDiscount.create!(name: "30% off", threshold: 30, percent_discount: 30, merchant_id: merchant_1.id)
      special_discount_10 = BulkDiscount.create!(name: "Special 10% off", threshold: 10, percent_discount: 10, merchant_id: merchant_2.id)

      visit "/merchants/#{merchant_1.id}/bulk_discounts"

      within "#discounts-#{discount_10.id}" do
        click_button "Delete"
        expect(current_path).to eq("/merchants/#{merchant_1.id}/bulk_discounts")
      end

      expect(page).to have_content('Spongebob The Merchant')
      expect(page).to have_content("20% off Purchase of 20 items")
      expect(page).to_not have_content("10% off Purchase of 10 items")
    end
  end

  describe "#API" do
    it 'displays the next three public holidays' do
      merchant_1 = Merchant.create!(name: 'Spongebob The Merchant')
      merchant_2 = Merchant.create!(name: 'Sandy The Squirrel Merchant')
      discount_10 = BulkDiscount.create!(name: "10% off", threshold: 10, percent_discount: 10, merchant_id: merchant_1.id)
      discount_20 = BulkDiscount.create!(name: "20% off", threshold: 20, percent_discount: 20, merchant_id: merchant_1.id)
      discount_30 = BulkDiscount.create!(name: "30% off", threshold: 30, percent_discount: 30, merchant_id: merchant_1.id)

      visit "/merchants/#{merchant_1.id}/bulk_discounts"

      within "#holidays0" do
        expect(page).to have_content("Labour Day")
        expect(page).to have_content("2022-09-05")
        expect(page).to_not have_content("Columbus Day")
      end

      within "#holidays1" do
        expect(page).to have_content("Columbus Day")
        expect(page).to have_content("2022-10-10")
        expect(page).to_not have_content("Labour Day")
      end

      within "#holidays2" do
        expect(page).to have_content("Veterans Day")
        expect(page).to have_content("2022-11-11")
        expect(page).to_not have_content("Columbus Day")
      end
    end
  end
end