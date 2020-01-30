class Booking

  attr_reader :booking_id, :confirmation, :start_date, :end_date, :list_name, :user, :price_per_night, :nights, :total_price, :listing_id

  def initialize(booking_id, confirmation, start_date, end_date, list_name, username, price_per_night, number_of_nights, total_price, listing_id)
    @booking_id = booking_id
    @confirmation = (confirmation == 't' ? true : false)
    @start_date = start_date
    @end_date = end_date
    @list_name = list_name
    @user = username
    @price_per_night = price_per_night
    @nights = number_of_nights
    @total_price = total_price
    @listing_id = listing_id
  end

  def self.setup(dbname)
    @dbconnection = dbname
  end

  def self.create(listing_id:, user_id:, start_date:, end_date:, confirmation: false)
    @dbconnection.command("INSERT INTO bookings(listing_id_fk, user_id_fk, start_date, end_date, confirmation) VALUES('#{listing_id}', '#{user_id}', '#{start_date}', '#{end_date}', false) ;")
  end

  def self.confirm(booking_id:)
    @dbconnection.command("UPDATE bookings SET confirmation = true WHERE booking_id = '#{booking_id}'")
  end

  def self.bookings(id)

    bookings = @dbconnection.command("SELECT b.booking_id, b.listing_id_fk,  b.start_date, b.end_date, b.confirmation, u.username, l.list_name, l.price_per_night FROM bookings b JOIN users u ON (b.user_id_fk=u.user_id) JOIN listings l ON (b.listing_id_fk=l.listing_id) WHERE b.listing_id_fk IN (SELECT listing_id FROM listings WHERE user_id_fk='#{id}');")



    if bookings == nil
      return []
    end

    bookings.map{ |booking|
      nights = number_of_nights(booking['start_date'], booking['end_date'])
      total = nights * booking['price_per_night'].to_i
      self.new(booking['booking_id'], booking['confirmation'], booking['start_date'], booking['end_date'], booking['list_name'], booking['username'], booking['price_per_night'], nights , total, booking['listing_id_fk'])}
  end

  private

  def self.number_of_nights(start_d, end_d)
    start_date = Date.parse(start_d)
    end_date = Date.parse(end_d)
    (end_date - start_date).to_i
  end

end
