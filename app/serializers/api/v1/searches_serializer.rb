class Api::V1::SearchesSerializer
  def initialize(start_date, end_date)
    @start_date = start_date
    @end_date = end_date
  end

  def search_data
    { search: {"startDate": @start_date, "endDate": @end_date},
      campsites: serialized_campsites,
      reservations: serialized_reservations
    }
  end

  def campsite_names
    booked_campsite_ids = Reservation.booked_campsites #=> [1, 2, 3]
    poss_campsite_ids = Campsite.where.not(id: booked_campsite_ids).pluck(:id) #=> [4, 5]
    poss_campsites = Campsite.where.not(id: booked_campsite_ids)
    prior_rezo_dates = poss_campsites.joins(:reservations).pluck(:start_date, :end_date)
    
    # return poss_campsites
    ## poss_campsites = campsites that would not be double booked by query time range (poss available)
    ## for each possible campsite
    ##   if it has a reso that starts x (two) days after query range
    ##   OR if it has a reso that starts x (two) days before query range
           ## gap beware
      ## else
        ## available!

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
