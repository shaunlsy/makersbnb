class Listing

  attr_reader :list_name, :list_id, :user_id, :username, :short_description, :price_per_night, :img_ref

  def initialize(list_name, list_id, user_id, username, short_description, price_per_night, img_ref)
    @list_name = list_name
    @list_id = list_id
    @user_id = user_id
    @username = username
    @short_description = short_description
    @price_per_night = price_per_night
    @img_ref = img_ref
  end

  def self.setup(dbname)
    @dbconnection = dbname
  end

  def self.all
    listings = @dbconnection.command('SELECT list_name, listing_id, user_id, username, short_description, price_per_night, img_ref FROM listings JOIN users ON (users.user_id=listings.user_id_fk)')

    listings.map{ |listing| self.new(listing['list_name'], listing['listing_id'], listing['user_id'], listing['username'], listing['short_description'], listing['price_per_night'], listing['img_ref'])}
  end

  def self.create(list_name:, user_id:, short_description:, price_per_night:)
    @dbconnection.command("INSERT INTO listings(list_name, user_id_fk, short_description, price_per_night) VALUES('#{list_name}', '#{user_id}', '#{short_description}', '#{price_per_night}') RETURNING img_ref;")[0]['img_ref']
  end

  def self.listing_query(id)
    @dbconnection.command("SELECT listing_id, list_name, short_description, price_per_night FROM listings WHERE listing_id='#{id}';")[0]
  end

  def self.my_listings(id)
    listings = @dbconnection.command("SELECT list_name, listing_id, user_id, username, short_description, price_per_night, img_ref FROM listings JOIN users ON (users.user_id=listings.user_id_fk) WHERE listings.user_id_fk='#{id}'")

    return [] unless listings

    listings.map{ |listing| self.new(listing['list_name'], listing['listing_id'], listing['user_id'], listing['username'], listing['short_description'], listing['price_per_night'], listing['img_ref'])}

  end
end
