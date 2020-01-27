feature 'Test infastructure' do
  scenario 'Homepage loads' do
    visit('/')
    expect(page).to have_content('Makersbnb')
  end
end
