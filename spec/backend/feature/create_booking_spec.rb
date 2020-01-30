feature 'Create booking' do
  scenario "user click book space button to book a listing" do
    @list_id 
    visit '/'
    login
    first('.listing > .listing-outline').click
    fill_in("start_date", with: "2020-01-27")
    fill_in("end_date", with: "2020-02-01")
    click_button "Book Space!"
    expect(page).to have_content "Booking made. Waiting for confirmation."
  end
end
