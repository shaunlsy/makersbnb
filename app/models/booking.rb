require 'date'
class Booking

  attr_reader :booking_id, :confirmation, :start_date, :end_date

  def initialize(booking_id, confirmation, start_date, end_date)
    @booking_id = booking_id
    @confirmation = confirmation
    @start_date = start_date
    @end_date = end_date
  end

  def self.setup(dbname)
    @dbconnection = dbname
  end

  def self.all
    bookings = @dbconnection.command('SELECT booking_id, start_date, end_date, confirmation FROM bookings JOIN users ON (users.user_id=bookings.user_id_fk) JOIN listings ON (listings.listing_id=bookings.listing_id_fk);')
    bookings.map{ |booking| self.new(booking['booking_id'], booking['confirmation'], booking['start_date'], booking['end_date'])}
  end

  def self.create(listing_id:, user_id:, start_date:, end_date:, confirmation: false)
    @dbconnection.command("INSERT INTO bookings(listing_id_fk, user_id_fk, start_date, end_date, confirmation) VALUES('#{listing_id}', '#{user_id}', '#{start_date}', '#{end_date}', false) ;")
  end

  def self.confirm(booking_id:)
    @dbconnection.command("UPDATE bookings SET confirmation = true WHERE booking_id = '#{booking_id}'")
  end

  def self.get_blocked_dates_range(listing_id:)
    dates = @dbconnection.command("SELECT start_date, end_date FROM bookings WHERE listing_id_fk='#{listing_id}'")
    booked_dates = dates.map{|booking| (Date.parse(booking['start_date'])..Date.parse(booking['end_date'])).to_a.map{|date| date.to_s}}
    booked_dates.flatten
  end

end
