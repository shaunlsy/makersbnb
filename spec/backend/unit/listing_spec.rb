require 'listing'

describe Listing do

  let(:subject) {Listing}

  describe ".all" do
    it "returns listings from the database" do
      expect(subject.all).to all(be_a(Listing))
    end
  end

  describe '.create' do
    it 'adds a listing to the database' do
      user_id = DatabaseConnection.command("INSERT INTO users(username) VALUES('test-username') RETURNING user_id;")[0]['user_id']
      subject.create(list_name: 'Users House', user_id: user_id, short_description: "Welcome", price_per_night: "100")
      expect(subject.all[-1].list_name).to eq 'Users House'
      expect(subject.all[-1].short_description ).to eq 'Welcome'
      expect(subject.all[-1].price_per_night).to eq '100'

    end
  end
end
