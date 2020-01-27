require 'listing'

describe "Listing" do

  let(:subject) {Listing}

  before(:each) do
    @user_id = DatabaseConnection.command("INSERT INTO users(username) VALUES('test-username') RETURNING user_id;")[0]['user_id']
  end

  describe ".all" do
    it "returns listings from the database" do
      expect(subject.all).to all(be_a(Listing))
    end
  end

  describe '.create' do
    it 'adds a listing to the database' do
      subject.create(list_name: 'Users House', user_id: @user_id)
      expect(subject.all[-1].list_name).to eq 'Users House'
    end
  end
end
