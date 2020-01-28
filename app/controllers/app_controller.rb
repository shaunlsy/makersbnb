$LOAD_PATH << './lib'
$LOAD_PATH << './app/controllers'
$LOAD_PATH << './app/models'

# Gems
require 'sinatra'
require 'pg'
require 'bcrypt'

# Models
require 'database_connection'
require 'listing'
require 'user'


class MakersbnbApp < Sinatra::Base
  # sets root as the parent-directory of the current file
  set :root, File.join(File.dirname(__FILE__), '..')
  set :views, Proc.new { File.join(root, "views") }
  set :public_folder, Proc.new { File.join(root, "../public") }

  DatabaseConnection.add_details(dbname: 'makersbnb', user: ENV['USER'], dbms: PG)
  Listing.setup(DatabaseConnection)
  User.setup(DatabaseConnection)

  enable :sessions

  get '/' do
    @log_in_action = params[:login]
    @list_of_listings = Listing.all
    @user = User.find(session[:user_id])
    erb :homepage
  end

  get '/create-listing' do
    @dbconnection = DatabaseConnection
    erb :create_listing
  end

  post '/listings' do
    Listing.create(list_name: params[:list_name], user_id: params[:user_id], short_description: params[:short_description], price_per_night: params[:price_per_night])
    redirect '/'
  end

  post '/sign-up' do
    session[:user_id] = User.create(params['username'], params['email'], params['password'])
    redirect '/'
  end

  post '/log-in' do
    session[:user_id] = User.authenticate(params[:log_in_email], params[:log_in_password])
    if session[:user_id] == nil
      string = "username or password incorrect, please try again"
    else 
      string = "Log in successful"
    end
    redirect "/?login=#{string}"
  end

  post '/log-out' do
    session[:user_id] = nil 
    redirect '/'
  end

  # start the server if ruby file executed directly
  run! if $0 == __FILE__
end
