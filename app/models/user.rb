require 'bcrypt'

class User

  attr_reader :email

  def self.setup(dbname)
    @dbconnection = dbname
  end

  def self.create(username, email, password)
    encrypted_password = BCrypt::Password.create(password)
    @dbconnection.command("INSERT INTO users(username, email, password) VALUES('#{username}', '#{email}', '#{encrypted_password}');")
  end

  def initialize(username, email)
    @username = username
    @email = email
  end


end