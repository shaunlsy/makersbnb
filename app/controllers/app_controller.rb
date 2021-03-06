$LOAD_PATH << './lib'
$LOAD_PATH << './app/controllers'
$LOAD_PATH << './app/models'

# Gems
require 'sinatra'
require 'pg'
require 'json'
require 'date'

# Models
require 'database_connection'
require 'listing'
require 'user'
require 'booking'
require 'message'



class MakersbnbApp < Sinatra::Base
  # sets root as the parent-directory of the current file
  set :root, File.join(File.dirname(__FILE__), '..')
  set :views, Proc.new { File.join(root, "views") }
  set :public_folder, Proc.new { File.join(root, "../public") }

  DatabaseConnection.add_details(dbname: 'makersbnb', user: ENV['USER'], dbms: PG)
  Listing.setup(DatabaseConnection)
  User.setup(DatabaseConnection)
  Booking.setup(DatabaseConnection)
  Message.setup(DatabaseConnection)

  enable :sessions

  get '/' do
    if params['logout'] == 'true'
      session[:user_id] = nil
      redirect '/'
    end
    @log_in_action = params[:login]
    @list_of_listings = Listing.all
    @user = User.find(session[:user_id])
    erb :homepage
  end

  get '/listing/:id' do
    data_hash = Listing.listing_query(params['id'])
    data_hash['date_range'] = Booking.get_blocked_dates_range(listing_id: params['id'])
    data_hash.to_json
  end

  post '/listing' do
    img_ref = Listing.create(list_name: params[:list_name], user_id: session[:user_id], short_description: params[:short_description], price_per_night: params[:price_per_night])

    begin
      img = params['datafile'][:tempfile]
      File.open("./public/media/#{img_ref}.jpg", 'wb') do |f|
        f.write(img.read)
      end
    rescue
      puts 'No image added'
      Listing.default_image(img_ref)
    end

    redirect '/'
  end

  post '/sign-up' do
    session[:user_id] = User.create(params['username'], params['email'], params['password'])
    redirect '/'
  end

  post '/log-in' do
    session[:user_id] = User.authenticate(params[:log_in_email], params[:log_in_password])
    if session[:user_id] == nil
      redirect "/?login=Username or password incorrect, please try again"
    end
    redirect '/'
  end

  get '/myaccount' do
    @user = User.find(session[:user_id])
    unless session[:user_id] == nil
      @mylistings = Listing.my_listings(session[:user_id])
      bookings = Booking.bookings(session[:user_id])
      @my_bookings_pending = bookings.select{|booking| booking.confirmation == false}
      @my_bookings_confirmed = bookings.select{|booking| booking.confirmation == true}
      trips = Booking.trips(session[:user_id])
      @my_trips_pending = trips.select{|trip| trip.confirmation == false}
      @my_trips_confirmed = trips.select{|trip| trip.confirmation == true}
    end
    erb :myaccount
  end

  put '/booking/:id' do
    Booking.confirm(booking_id: params['id'])
    'Booking Confirmed'
  end

  delete '/booking/:id' do
    Booking.decline(booking_id: params['id'])
    'Booking Declined'
  end

  post '/make-booking' do
    @user = session[:user_id]
    Booking.create(listing_id: params[:listing_id] ,user_id: @user, start_date: params[:start_date], end_date: params[:end_date], confirmation: false)
    redirect '/make-booking'
  end

  get '/make-booking' do
    erb :booking_confirmation
  end

  get '/message/:user_1_id/:user_2_id' do
    Message.get_message(user_1: params[:user_1_id], user_2: params[:user_2_id]).to_json
  end

  post '/message' do
    hash = JSON.parse(request.body.read)
    Message.create(receiver_id: hash['user_2'], messenger_id: hash['user_1'], message: hash['message'])
  end

  # start the server if ruby file executed directly
  run! if $0 == __FILE__
end
