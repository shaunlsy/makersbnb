ENV['RACK_ENV'] = 'PRODUCTION'
ENV['ENVIRONMENT'] = 'development'
require_relative "./app/controllers/app_controller.rb"

run MakersbnbApp
