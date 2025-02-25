require 'rails_helper'

RSpec.describe 'admin merchant new page' do
  describe '#create' do
    it 'creates a new merchant and redirects back to admin merchant index page' do

      visit "admin/merchants/new"

      fill_in('Name', with: 'Curious Imports')
      click_button('Create')

      visit "admin/merchants"

      expect(page).to have_content('Curious Imports')
    end

    it 'gives error message when field is left blank' do

      visit "admin/merchants/new"

      fill_in('Name', with: '')
      click_button('Create')

      expect(page).to have_content("Error: Field Cannot Be Blank")
    end
  end
end