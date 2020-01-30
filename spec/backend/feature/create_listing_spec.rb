feature 'create listings' do
  scenario "user creates listing", js: true do
    login
    add_listing
    expect(page).to have_content "Users house"
    expect(page).to have_content "£150"
  end
end
