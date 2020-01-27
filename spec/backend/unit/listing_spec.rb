require 'listing'

describe "Listing" do

  let(:subject) {Listing}

  before(:each) do
    Listing.setup(DatabaseConnection)
  end

  describe ".all" do
    it "returns listings from the database" do
      expect(subject.all).to all(be_a(Listing))
    end
  end
end