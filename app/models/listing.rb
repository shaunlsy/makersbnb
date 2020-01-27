class Listing 

  attr_reader :list_name, :list_id, :user_id, :username

  def initialize(list_name, list_id, user_id, username)
    @list_name = list_name
    @list_id = list_id
    @user_id = user_id
    @username = username
  end

  def self.setup(dbname) 
    @dbconnection = dbname
  end

  def self.all
    listings = @dbconnection.command('SELECT list_name, listing_id, user_id, username FROM listings JOIN users ON (users.user_id=listings.listing_id)')

    listings.map{ |listing| self.new(listing['list_name'], listing['listing_id'], listing['user_id'], listing['username'])}
  end
end