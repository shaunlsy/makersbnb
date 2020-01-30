task default: %w[test_tables]

task :bundle do
  puts 'Installing bundle...'
  sh 'gem install bundler'
end

task :gems => [:bundle] do
  puts 'Running bundle...'
  sh 'bundle'
end

task :postgresql => [:gems] do
  puts 'Installing postgresql...'
  sh 'brew install postgresql'
end

task :database => [:postgresql] do
  puts 'Clearing and creating databases...'
  begin
    sh "dropdb 'makersbnb-development'"
  rescue => e
    puts e
  end
  begin
    sh "createdb 'makersbnb-development'"
  rescue => e
    puts e
  end
  begin
    sh "dropdb 'makersbnb-test'"
  rescue => e
    puts e
  end
  begin
    sh "createdb 'makersbnb-test'"
  rescue => e
    puts e
  end

end

task :development_tables => [:database] do
  puts 'Creating development tables...'
  sh %Q[psql -U #{ENV['USER']} -d makersbnb-development --command="CREATE TABLE users(user_id SERIAL PRIMARY KEY, username VARCHAR, email VARCHAR, password VARCHAR);"]
  sh %Q[psql -U #{ENV['USER']} -d makersbnb-development --command="CREATE TABLE listings(listing_id SERIAL PRIMARY KEY, list_name VARCHAR, user_id_fk INTEGER REFERENCES users(user_id), short_description VARCHAR, price_per_night INTEGER, img_ref SERIAL);"]
  sh %Q[psql -U #{ENV['USER']} -d makersbnb-development --command="CREATE TABLE bookings(booking_id SERIAL PRIMARY KEY, listing_id_fk INTEGER REFERENCES listings(listing_id), user_id_fk INTEGER REFERENCES users(user_id), start_date DATE, end_date DATE, confirmation BOOLEAN);"]
end

task :seed_development_tables => [:development_tables] do
  puts 'Adding to development database...'
  sh %Q[psql -U #{ENV['USER']} -d makersbnb-development --command="INSERT INTO users(username, email, password) VALUES('test-username', 'test@test.com', 'password');"]
  sh %Q[psql -U #{ENV['USER']} -d makersbnb-development --command="INSERT INTO listings(list_name, user_id_fk, short_description, price_per_night) VALUES('The makers loft', '1', 'Beautiful house', '123');"]
  sh %Q[psql -U #{ENV['USER']} -d makersbnb-development --command="INSERT INTO bookings(listing_id_fk, user_id_fk, start_date, end_date, confirmation) VALUES('1', '1', '2020-01-01', '2020-02-01', 'true');"]
end

task :test_tables => [:seed_development_tables] do
  puts 'Creating test tables...'
  sh %Q[psql -U #{ENV['USER']} -d makersbnb-test --command="CREATE TABLE users(user_id SERIAL PRIMARY KEY, username VARCHAR, email VARCHAR, password VARCHAR);"]
  sh %Q[psql -U #{ENV['USER']} -d makersbnb-test --command="CREATE TABLE listings(listing_id SERIAL PRIMARY KEY, list_name VARCHAR, user_id_fk INTEGER REFERENCES users(user_id), short_description VARCHAR, price_per_night INTEGER, img_ref SERIAL);"]
  sh %Q[psql -U #{ENV['USER']} -d makersbnb-test --command="CREATE TABLE bookings(booking_id SERIAL PRIMARY KEY, listing_id_fk INTEGER REFERENCES listings(listing_id), user_id_fk INTEGER REFERENCES users(user_id), start_date DATE, end_date DATE, confirmation BOOLEAN);"]
end

task :production_database do
  puts 'Creating production database...'
  begin
    sh "createdb 'makersbnb-production'"
  rescue => e
    puts e
  end
  puts 'Creating production tables...'
  sh %Q[psql -U #{ENV['USER']} -d makersbnb-production --command="CREATE TABLE users(user_id SERIAL PRIMARY KEY, username VARCHAR, password VARCHAR);"]
  sh %Q[psql -U #{ENV['USER']} -d makersbnb-production --command="CREATE TABLE listings(listing_id SERIAL PRIMARY KEY, list_name VARCHAR, user_id_fk INTEGER REFERENCES users(user_id), short_description VARCHAR, price_per_night INTEGER, img_ref SERIAL);"]
  sh %Q[psql -U #{ENV['USER']} -d makersbnb-production --command="CREATE TABLE bookings(booking_id SERIAL PRIMARY KEY, listing_id_fk INTEGER REFERENCES listings(listing_id), user_id_fk INTEGER REFERENCES users(user_id), start_date DATE, end_date DATE, confirmation BOOLEAN);"]
end
