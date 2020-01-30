def login
  visit '/'
  click_button('Register')
  fill_in("username", with: 'User')
  fill_in("email", with: 'user@test.com')
  fill_in("password", with: 'password')
  click_button 'Sign up'
end

def add_listing
  find('.drop-down-container').hover
  find(:xpath, "//a[@id='create-listing']").click
  fill_in("list_name", with: "Users house")
  fill_in("short_description", with: "My house is superb!")
  fill_in("price_per_night", with: "150")
  click_button "Add listing"
end
