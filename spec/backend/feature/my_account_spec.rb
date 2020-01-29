feature 'my account' do
  scenario 'button takes the user to their account page', js: true do
    login

    find('.drop-down-container').hover
    find(:xpath, "//a[@href='/myaccount']").click
    expect(page).to have_content 'My Account'
  end
end
