require 'bcrypt'

class User

  attr_reader :email

  def initialize(username, email)
    @username = username
    @email = email
  end

  def self.setup(dbname)
    @dbconnection = dbname
  end

  def self.create(username, email, password)
    encrypted_password = BCrypt::Password.create(password)
    @dbconnection.command("INSERT INTO users(username, email, password) VALUES('#{username}', '#{email}', '#{encrypted_password}');")
  end

  def self.authenticate(email, password)
    begin
      database_password = @dbconnection.command("SELECT password FROM users WHERE email='#{email}';")[0]['password']
    rescue
      return nil
    end
    if BCrypt::Password.new(database_password) == password
      user_id = @dbconnection.command("SELECT user_id FROM users WHERE email='#{email}';")[0]['user_id']
      return user_id
    else
      return nil
    end
  end

end
