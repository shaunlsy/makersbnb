#add simple cov setup to rspec setup file=>>
require 'simplecov'
require 'simplecov-console'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([SimpleCov::Formatter::Console])
SimpleCov.start

#set up environment
ENV['RACK_ENV'] = 'test'
ENV['ENVIRONMENT'] = 'test'
$LOAD_PATH << './app/controllers'

#add capybara setup
require 'capybara'
require 'capybara/dsl'
require 'capybara/rspec'
require 'app_controller'
require 'web_helpers'

Capybara.app = MakersbnbApp


RSpec.configure do |config|

  config.before(:each) do

    con = PG.connect(:dbname => 'makersbnb-test', :user => ENV['USER'])
    # add test user
    user_id = con.exec("INSERT INTO users(username) VALUES('test-username') RETURNING user_id;")
    user_id = user_id[0]['user_id']
    # add test listing
    listing_id = con.exec("INSERT INTO listings(list_name, user_id_fk) VALUES('Test listing 1', '#{user_id}') RETURNING listing_id;")
    listing_id = listing_id[0]['listing_id']
    # add test comments
    con.exec("INSERT INTO bookings(listing_id_fk, user_id_fk, start_date, end_date, confirmation) VALUES('#{listing_id}','#{user_id}','2020-01-02','2020-01-05','TRUE');")
  end

  config.after(:each) do
    con = PG.connect(:dbname => 'makersbnb-test', :user => ENV['USER'])
    # wipe database after test
    con.exec("TRUNCATE users, listings, bookings;")
  end

  # Use color not only in STDOUT but also in pagers and files
  config.tty = true

  # Use the specified formatter
  config.formatter = :documentation

  config.after(:suite) do
    puts
  end
end
