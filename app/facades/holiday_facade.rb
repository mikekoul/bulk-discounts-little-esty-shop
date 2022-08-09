class HolidayFacade

  def self.three_upcoming_holidays
    parsed = HolidayService.holidays
    parsed[0..2].map do |data|
      Holiday.new(data)
    end
  end
end