def login
  visit '/'
  fill_in("username", with: 'User')
  fill_in("email", with: 'user@test.com')
  fill_in("password", with: 'password')
  click_button 'Sign up'
end

def login_add_listing_account
  login
  click_button 'Create a new listing!'
  fill_in("list_name", with: "Users house")
  fill_in("short_description", with: "My house is superb!")
  fill_in("price_per_night", with: "150")
  click_button "Add listing"
  click_button "myaccount"
end
