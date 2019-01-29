class Seed

  def self.start
    clear_prior_data
    seed_data
    puts "Successfully seeded all data!"
  end

  def self.clear_prior_data
    Campsite.destroy_all
    Reservation.destroy_all
  end

  def self.seed_data
    camp_1 = Campsite.create(name: "Cozy Cabin")
    camp_2 = Campsite.create(name: "Comfy Cabin")
    camp_3 = Campsite.create(name: "Rustic Cabin")
    camp_4 = Campsite.create(name: "Rickety Cabin")
    Campsite.create(name: "Cabin in the Woods")

    Reservation.create(
      campsite_id: camp_1.id,
      start_date: Date.new(2018, 6, 1),
      end_date: Date.new(2018, 6, 3),
    )
    Reservation.create(
      campsite_id: camp_1.id,
      start_date: Date.new(2018, 6, 8),
      end_date: Date.new(2018, 6, 10),
    )
    Reservation.create(
      campsite_id: camp_2.id,
      start_date: Date.new(2018, 6, 1),
      end_date: Date.new(2018, 6, 1),
    )
    Reservation.create(
      campsite_id: camp_2.id,
      start_date: Date.new(2018, 6, 2),
      end_date: Date.new(2018, 6, 3),
    )
    Reservation.create(
      campsite_id: camp_2.id,
      start_date: Date.new(2018, 6, 7),
      end_date: Date.new(2018, 6, 9),
    )
    Reservation.create(
      campsite_id: camp_3.id,
      start_date: Date.new(2018, 6, 1),
      end_date: Date.new(2018, 6, 2),
    )
    Reservation.create(
      campsite_id: camp_3.id,
      start_date: Date.new(2018, 6, 8),
      end_date: Date.new(2018, 6, 9),
    )
    Reservation.create(
      campsite_id: camp_4.id,
      start_date: Date.new(2018, 6, 7),
      end_date: Date.new(2018, 6, 10),
    )
  end
end

Seed.start
