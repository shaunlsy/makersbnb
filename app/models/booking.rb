class Booking

  def initialize(booking_id, confirmation)
    @booking_id = booking_id
    @confirmation = confirmation
  end

  def self.setup(dbname)
    @dbconnection = dbname
  end

  def self.all
    bookings = @dbconnection.command('SELECT booking_id, confirmation FROM bookings JOIN users ON (users.user_id=bookings.user_id_fk) JOIN listings ON (listings.listing_id=bookings.listing_id_fk);')
    bookings.map{ |booking| self.new(booking['booking_id'], booking['confirmation'])}
  end

end
