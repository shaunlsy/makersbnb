task default: %w[test_tables]

# task :bundle do
#   puts 'Installing bundle...'
#   sh 'gem install bundler'
# end
#
# task :gems => [:bundle] do
#   puts 'Running bundle...'
#   sh 'bundle'
# end

task :postgresql do
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
  sh %Q[psql -U #{ENV['USER']} -d makersbnb-development --command="CREATE TABLE users(user_id SERIAL PRIMARY KEY, username VARCHAR);"]
  sh %Q[psql -U #{ENV['USER']} -d makersbnb-development --command="CREATE TABLE listings(listing_id SERIAL PRIMARY KEY, list_name VARCHAR, user_id_fk INTEGER REFERENCES users(user_id));"]
end

task :test_tables => [:development_tables] do
  puts 'Creating test tables...'
  sh %Q[psql -U #{ENV['USER']} -d makersbnb-test --command="CREATE TABLE users(user_id SERIAL PRIMARY KEY, username VARCHAR);"]
  sh %Q[psql -U #{ENV['USER']} -d makersbnb-test --command="CREATE TABLE listings(listing_id SERIAL PRIMARY KEY, list_name VARCHAR, user_id_fk INTEGER REFERENCES users(user_id));"]
end

task :production_database do
  puts 'Creating production database...'
  begin
    sh "createdb 'makersbnb-production'"
  rescue => e
    puts e
  end
  puts 'Creating production tables...'
  sh %Q[psql -U #{ENV['USER']} -d makersbnb-production --command="CREATE TABLE users(user_id SERIAL PRIMARY KEY, username VARCHAR);"]
  sh %Q[psql -U #{ENV['USER']} -d makersbnb-production --command="CREATE TABLE listings(listing_id SERIAL PRIMARY KEY, list_name VARCHAR, user_id_fk INTEGER REFERENCES users(user_id));"]
end
