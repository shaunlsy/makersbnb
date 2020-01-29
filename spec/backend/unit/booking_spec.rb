require 'booking'
describe Booking do

  let(:subject){ Booking }

  describe '.all' do
    it "returns bookings from the database" do
      expect(subject.all).to all(be_a(Booking))
    end
  end

  # describe '.create' do
  #   it 'adds a booking request into the database' do
  #     user_id = DatabaseConnection.command("INSERT INTO users(username) VALUES('test-username') RETURNING user_id;")[0]['user_id']

 
end


