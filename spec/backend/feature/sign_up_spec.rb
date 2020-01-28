feature 'sign up' do
  scenario 'allows a user to sign up' do
  visit('/')
  fill_in("username", with: 'User')
  fill_in("email", with: 'user@test.com')
  fill_in("password", with: 'password')
  click_button 'Sign up'
  expect(page).to have_content 'Welcome User'
  end
end