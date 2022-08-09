require 'rails_helper'

RSpec.describe HolidayService do
  it 'exists' do
    hs = HolidayService.holidays

    expect(hs).to be_a(Array)
  end
end