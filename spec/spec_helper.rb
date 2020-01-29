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
require "selenium-webdriver"
require 'puma'
require 'app_controller'
require 'web_helpers'
require 'capybara/poltergeist'


Capybara.javascript_driver = :selenium
Capybara.server = :puma, { Silent: true }
Capybara.app = MakersbnbApp


RSpec.configure do |config|

  config.before(:each) do

    con = PG.connect(:dbname => 'makersbnb-test', :user => ENV['USER'])
    # add test user
    user_id = con.exec("INSERT INTO users(username) VALUES('test-username') RETURNING user_id;")
    user_id = user_id[0]['user_id']
    # add test messages
    con.exec("INSERT INTO listings(list_name, user_id_fk, short_description, price_per_night) VALUES('Test listing 1', '#{user_id}', 'im a description', '100');")
    # add test comments
  end

  config.after(:each) do
    con = PG.connect(:dbname => 'makersbnb-test', :user => ENV['USER'])
    # wipe database after test
    con.exec("TRUNCATE users, listings;")
  end

  # Use color not only in STDOUT but also in pagers and files
  config.tty = true

  # Use the specified formatter
  config.formatter = :documentation

  config.after(:suite) do
    puts
  end
end
