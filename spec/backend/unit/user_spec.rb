require 'user'

describe User do

  before(:each) do
    User.setup(DatabaseConnection)
  end

  describe ".create" do
    let(:dbconnection) {double :dbconnection, :command => nil}
    it "creates a new user in the table" do
      User.setup(dbconnection)
      allow(BCrypt::Password).to receive(:create).and_return("encrypted password")
      expect(dbconnection).to receive(:command).with("INSERT INTO users(username, email, password) VALUES('test_username', 'test@test.com', 'encrypted password');")
      User.create('test_username','test@test.com', 'password')
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

end
