feature 'Clickable listing' do
  scenario "user clicks listing and it takes them to listing page" do
    visit '/'
    listing_id = Database.command("SELECT listing_id FROM listings;")[0]['listing_id']
    page.find("#listing_id_#{listing_id}").click
    expect(current_path).to eq "/listing/#{listing_id}"
    expect(page).to have_content('Test listing 1')
    expect(page).to have_content('Confirm Booking')
  end
end
