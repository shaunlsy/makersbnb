feature 'Create booking' do
  scenario "user click book space button to book a listing" do
    visit '/'
    login
    book_space
    expect(page).to have_content "Booking made. Waiting for confirmation."
  end
end
