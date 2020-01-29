require 'listing'

describe Listing do

  let(:subject) {Listing}

  before(:each) do
    @user_id = DatabaseConnection.command("SELECT user_id FROM users;")[0]['user_id']
  end

  describe ".all" do
    it "returns listings from the database" do
      expect(subject.all).to all(be_a(Listing))
    end
  end

  describe '.create' do
    it 'adds a listing to the database' do
      subject.create(list_name: 'Users House', user_id: @user_id, short_description: "Welcome", price_per_night: "100")
      expect(subject.all[-1].list_name).to eq 'Users House'
      expect(subject.all[-1].short_description ).to eq 'Welcome'
      expect(subject.all[-1].price_per_night).to eq '100'
    end
  end

  describe '.listing_query' do
    it 'returns specific listing information as hash' do
      listing_id = DatabaseConnection.command("INSERT INTO listings(list_name, user_id_fk, short_description, price_per_night) VALUES('test name', '#{@user_id}', 'test description', '150') RETURNING listing_id;")[0]['listing_id']
      expect(subject.listing_query(listing_id)).to eq({'listing_id' => listing_id, 'list_name' => 'test name', 'short_description' => 'test description', 'price_per_night' => '150'})
    end
  end
end
