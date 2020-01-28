def login
  visit '/'
  fill_in("username", with: 'User')
  fill_in("email", with: 'user@test.com')
  fill_in("password", with: 'password')
  click_button 'Sign up'
end
