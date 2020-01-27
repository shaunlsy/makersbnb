feature 'create listings' do
  scenario "user clicks 'create listing' buttons to create listing" do
    visit '/'
    click_button 'Create a new listing!'
    expect(current_path).to eq '/create-listing'
    expect(page).to have_content 'Listings'
  end
end
