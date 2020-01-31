class Message
  attr_reader :message_id, :message, :receiver_id, :messager_id, :time_inserted

  def initialize(message_id, receiver_id, messenger_id, message, time_inserted)
    @message_id = message_id
    @receiver_id = receiver_id
    @messenger_id = messenger_id
    @message = message
    @time_inserted = time_inserted
  end

  def self.setup(dbname)
    @dbconnection = dbname
  end

  def self.all
    messages = @dbconnection.command(
      'SELECT m.message_id, m.receiver_id_fk, m.messenger_id_fk, m.message, m.time_inserted
      FROM messages m 
      JOIN users ru ON ru.user_id=m.receiver_id_fk 
      JOIN users su ON su.user_id=m.messenger_id_fk
      ORDER BY m.time_inserted DESC')
    messages.map{ |message| self.new(message['message_id'], message['receiver_id_fk'], message['messenger_id_fk'], message['message'], message['time_inserted'])}
  end

  def self.create(receiver_id:, messenger_id:, message:)
    @dbconnection.command("INSERT INTO messages(receiver_id_fk, messenger_id_fk, message) VALUES('#{receiver_id}', '#{messenger_id}', '#{message}')")
  end

  def self.get_message(user_1:  , user_2: )
    messages = @dbconnection.command("SELECT message, messenger_id_fk, receiver_id_fk FROM messages WHERE receiver_id_fk = '#{user_1}' AND messenger_id_fk = '#{user_2}' OR receiver_id_fk = '#{user_2}' AND messenger_id_fk = '#{user_1}';")
    messages.map { |message| {sender_id: message['messenger_id_fk'], receiver_id: message['receiver_id_fk'], message: message['message']} }
  end

end