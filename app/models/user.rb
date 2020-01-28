require 'digest'

class User

  attr_reader :email, :username, :logged_in

  def initialize(username = nil, email = nil)
    @username = username
    @email = email
    @logged_in = (username ? true : false)
  end

  def self.setup(dbname)
    @dbconnection = dbname
  end

  def self.create(username, email, password)
    encrypted_password = Digest::SHA256.hexdigest(password)
    @dbconnection.command("INSERT INTO users(username, email, password) VALUES('#{username}', '#{email}', '#{encrypted_password}') RETURNING user_id;")[0]['user_id']
  end

  def self.authenticate(email, password)
    p password
    begin
      database_password = @dbconnection.command("SELECT password FROM users WHERE email='#{email}';")[0]['password']
    rescue
      return nil
    end
    if database_password == Digest::SHA256.hexdigest(password)
      user_id = @dbconnection.command("SELECT user_id FROM users WHERE email='#{email}';")[0]['user_id']
      return user_id
    else
      p 'password fail'
      return nil
    end
  end

  def self.find(user_id)
    if user_id == nil
      return self.new()
    end
    user_data = @dbconnection.command("SELECT username, email FROM users WHERE user_id='#{user_id}';")[0]
    self.new(user_data['username'], user_data['email'])
  end

end
