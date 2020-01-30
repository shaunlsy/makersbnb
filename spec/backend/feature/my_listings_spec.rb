feature 'my listings' do
  scenario 'all of users listings shown', js: true do
    login
    add_listing

    find('.drop-down-container').hover
    find(:xpath, "//a[@href='/myaccount']").click
    expect(page).to have_content "Users house"
  end

  scenario 'all of users pending bookings are shown', js: true do
    login
    add_listing
    # logout
    # add booking under different user
    # login
    # go to my accounts
    find('.drop-down-container').hover
    find(:xpath, "//a[@href='/myaccount']").click
    find(:xpath, "//button[@id='mybookingsbtn']").click
    # expect to see new booking by other user
  end
end
