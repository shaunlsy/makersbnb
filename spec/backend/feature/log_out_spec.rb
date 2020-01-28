feature 'logging out' do
  scenario 'it allows a user to logut' do
    visit '/'
    fill_in("username", with: 'User')
    fill_in("email", with: 'user@test.com')
    fill_in("password", with: 'password')
    click_button 'Sign up'

    
    click_button 'Log out'
    expect(page).to_not have_content "Welcome User"
  end
end