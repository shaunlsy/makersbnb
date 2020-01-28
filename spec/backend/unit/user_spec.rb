require 'user'

describe User do

  before(:each) do
    User.setup(DatabaseConnection)
  end

  describe ".create" do
    let(:dbconnection) {double :dbconnection, :command => [{"user_id" => '1'}]}
    it "creates a new user in the table" do
      User.setup(dbconnection)
      allow(Digest::SHA256).to receive(:hexdigest).and_return("encrypted password")
      expect(dbconnection).to receive(:command).with("INSERT INTO users(username, email, password) VALUES('test_username', 'test@test.com', 'encrypted password') RETURNING user_id;")
      User.create('test_username','test@test.com', 'password')
    end
    it "returns a user ID" do
      expect(User.create('test_username','test@test.com', 'password')).to be_a_kind_of(String)
    end
  end

  describe ".authenticate" do
    it 'returns user_id of register user if credentials are correct' do
      User.create('test_username','test@test.com', 'password')
      real_user_id = DatabaseConnection.command("SELECT user_id FROM users WHERE email='test@test.com'")[0]['user_id']
      user_id = User.authenticate('test@test.com', 'password')
      expect(user_id).to eq(real_user_id)
    end
    it 'returns nil if email is incorrect' do
      expect(User.authenticate('im_not_in_the_database@notanemail.moc', 'password')).to eq(nil)
    end
    it 'returns nil if email is incorrect' do
      User.create('test_username','test@test.com', 'password')
      expect(User.authenticate('test@test.com', 'wrong password')).to eq(nil)
    end
  end

  describe '.find' do
    it 'finds user by id and returns user instance' do
      user_id = User.create('test_username','test@test.com', 'password')
      user = User.find(user_id)
      expect(user).to be_a_kind_of(User)
      expect(user.email).to eq('test@test.com')
      expect(user.username).to eq('test_username')
      expect(user.logged_in).to be(true)
    end
    it 'returns logged out user instance if no id provided' do
      user = User.find(nil)
      expect(user).to be_a_kind_of(User)
      expect(user.logged_in).to be(false)
    end
  end

end
