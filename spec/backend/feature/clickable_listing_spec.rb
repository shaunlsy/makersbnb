feature 'Clickable listing' do
  scenario "user clicks listing and it shows descripton", js: true do
    visit '/'
    first('.listing > .listing-outline').click
    expect(page).to have_content('im a description')
  end
end
