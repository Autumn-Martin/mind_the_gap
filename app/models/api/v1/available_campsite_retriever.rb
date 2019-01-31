class Api::V1::AvailableCampsiteRetriever
  def initialize(data)
    @start_date = data[:search][:startDate]
    @end_date = data[:search][:endDate]
    @campsites = data[:campsites]
    @rezos = data[:reservations]
  end

  def days
    @start_date
  end

  def update_campsites
    if @campsites.count > Campsite.all.count
      @campsites.each do |campsite|
        Campsite.find_or_create_by(id: campsite[:id], name: campsite[:name])
      end
    end
  end

  def update_reservations
    if @rezos.count > Reservation.all.count
      @rezos.each do |rezo|
        Reservation.find_or_create_by(campsite_id: rezo[:campsiteId], start_date: rezo[:startDate], end_date: rezo[:endDate])
      end
    end
  end

  def update_data
    update_campsites
    update_reservations
  end

  def available_campsites
    update_data # if retrieve data from an external API endpoint instead, this will update the internal database
    booked_campsite_ids = Reservation.booked_campsites #=> [1, 2, 3]
    poss_campsite_ids = Campsite.where.not(id: booked_campsite_ids).pluck(:id) #=> [4, 5]
    poss_campsites = Campsite.where.not(id: booked_campsite_ids)
    prior_rezo_dates = poss_campsites.joins(:reservations).pluck(:start_date, :end_date)
    available_spots = []
    poss_campsites.each do |campsite|
      campsite_rezo_dates = campsite.reservations.pluck(:start_date, :end_date)
      if campsite_rezo_dates.include?(Date.strptime(@start_date, '%Y-%m-%d') - 2) && campsite_rezo_dates.exclude?(Date.strptime(@start_date, '%Y-%m-%d') - 1)
        available_spots
      elsif campsite_rezo_dates.include?(Date.strptime(@end_date, '%Y-%m-%d') + 2) && campsite_rezo_dates.exclude?(Date.strptime(@end_date, '%Y-%m-%d') + 1)
        available_spots
      else
        available_spots << campsite
      end
    end
    return available_spots.pluck(:name)
  end
end
