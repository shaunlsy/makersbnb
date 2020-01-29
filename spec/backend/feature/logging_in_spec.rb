feature "logging in" do
  scenario "a user can login" do
    User.create('test', 'user_test@test.com', 'password')
    visit('/')
    fill_in "log_in_email", with: 'user_test@test.com'
    fill_in "log_in_password", with: 'password'
    click_button "log in"
    expect(page).to have_content('test')
  end
  scenario "it provides not when incorrect credentials are provided" do
    User.create('test', 'user_test@test.com', 'password')
    visit('/')
    fill_in "log_in_email", with: 'user_test@test.com'
    fill_in "log_in_password", with: 'incorrect_password'
    click_button "log in"
    expect(page).to have_content('test')
    expect(page).to have_content('Username or password incorrect, please try again')
    end
end
