require 'user'

describe User do
  
  describe "#create" do
    let(:dbconnection) {double :dbconnection, :command => nil}
    it "creates a new user in the table" do
      User.setup(dbconnection)
      allow(BCrypt::Password).to receive(:create).and_return("encrypted password")
      expect(dbconnection).to receive(:command).with("INSERT INTO users(username, email, password) VALUES('test_username', 'test@test.com', 'encrypted password');")
      User.create('test_username','test@test.com', 'password')
    end
  end
  
end