class Api::V1::SearchesSerializer
  def initialize(start_date, end_date)
    @start_date = start_date.gsub(/[.\/]/, '-')
    @end_date = end_date.gsub(/[.\/]/, '-')
  end

  def search_data
    { search: {"startDate": @start_date, "endDate": @end_date},
      campsites: serialized_campsites,
      reservations: serialized_reservations
    }
  end

  private

  def serialized_campsites
    unserialized_campsites.map do |campsite|
      {"id": campsite.id, "name": campsite.name}
    end
  end

  def unserialized_campsites
    Campsite.all
  end

  def serialized_reservations
    unserialized_reservations.map do |reservation|
      { "campsiteId": reservation.campsite_id,
        "startDate": reservation.start_date,
        "endDate": reservation.end_date
      }
    end
  end

  def unserialized_reservations
    Reservation.all
  end
end
