require 'message'
require 'time'

describe Message do
  let(:subject){ Message }

  before(:each) do
    DatabaseConnection.command("INSERT INTO users(username) VALUES('test-username-2') RETURNING user_id;")
    users = DatabaseConnection.command("SELECT user_id FROM users;")
    @user_1 = users[0]['user_id']
    @user_2 = users[1]['user_id']
  end


  describe ".all" do
      it "returns messages from the database" do
        expect(subject.all).to all(be_a(Message))
      end
  end

  describe '.create' do
    it 'adds message into the database' do
      subject.create(receiver_id: @user_2, messenger_id: @user_1, message: "Hi, User 2")
      expect(subject.all[0].message).to eq("Hi, User 2")
      expect(subject.all[-1].message).to eq("hello user 1")
    end
  end



end
