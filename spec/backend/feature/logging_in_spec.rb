feature "logging in" do
  scenario "it checks that a user exists before logging in" do
    User.create('test', 'user_test@test.com', 'password')
    visit('/')
    fill_in "log_in_email", with: 'user_test@test.com'
    fill_in "log_in_password", with: 'password'
    click_button "log in"
    expect(page).to have_content "test"
    end
end
