feature 'my account' do
  scenario 'button takes the user to their account page' do
    login
    page.find('#myaccount').click

    expect(page).to have_content 'My Account'
  end
end
