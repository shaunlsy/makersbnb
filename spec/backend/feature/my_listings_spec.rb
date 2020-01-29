feature 'my listings' do
  scenario 'all of users listings shown' do
    login_add_listing_account
    expect(page).to have_content "Users house"
  end
end