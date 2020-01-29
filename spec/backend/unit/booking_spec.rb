require 'booking'
describe Booking do

  let(:subject){ Booking }

  before(:each) do
    @user_id = DatabaseConnection.command("SELECT user_id FROM users;")[0]['user_id']
    @listing_id = DatabaseConnection.command("SELECT listing_id FROM listings;")[0]['listing_id']
  end

  describe '.all' do
    it "returns bookings from the database" do
      expect(subject.all).to all(be_a(Booking))
    end
  end

  describe '.create' do
    it 'adds a booking request into the database' do
      subject.create(listing_id: @listing_id, user_id: @user_id, start_date:'2020-07-08', end_date:'2020-07-10')
      expect(subject.all[-1].start_date).to eq '2020-07-08'
      expect(subject.all[-1].end_date).to eq '2020-07-10'
    end
  end

  describe ".confirm" do
    it "changes the booking confirmation from false to true" do
      subject.confirm(booking_id: 1)
      expect(subject.all[-1].confirmation).to eq 't'
    end
  end
end