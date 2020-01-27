$LOAD_PATH << './lib'
$LOAD_PATH << './app/controllers'
$LOAD_PATH << './app/models'

# Gems
require 'sinatra'
require 'pg'

# Models
require 'database_connection'
require 'listing'


class MakersbnbApp < Sinatra::Base
  # sets root as the parent-directory of the current file
  set :root, File.join(File.dirname(__FILE__), '..')
  set :views, Proc.new { File.join(root, "views") }
  set :public_folder, Proc.new { File.join(root, "../public") }

  DatabaseConnection.add_details(dbname: 'makersbnb', user: ENV['USER'], dbms: PG)
  Listing.setup(DatabaseConnection)

  get '/' do
    @list_of_listings = Listing.all
    erb :homepage
  end

  get '/create-listing' do
    @dbconnection = DatabaseConnection
    erb :create_listing
  end

  post '/listings' do
    p params
    Listing.create(list_name: params[:list_name], user_id: params[:user_id])
    redirect '/'
  end

  # start the server if ruby file executed directly
  run! if $0 == __FILE__
end
