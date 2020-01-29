feature 'my listings' do
  scenario 'all of users listings shown', js: true do
    login
    add_listing

    find('.drop-down-container').hover
    find(:xpath, "//a[@href='/myaccount']").click
    expect(page).to have_content "Users house"
  end
end
