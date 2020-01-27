feature 'create listings' do
  scenario "user clicks 'create listing' buttons to create listing" do
    visit '/'
    click_button 'Create a new listing!'
    expect(current_path).to eq '/create-listing'
    expect(page).to have_content 'Insert Your Listing'
  end

  scenario "user clicks 'create listing' buttons to create listing" do
    visit '/'
    click_button 'Create a new listing!'
    expect(current_path).to eq '/create-listing'
    fill_in("listing_name", with: "Users' house")
    click_button "Add listing"
    expect(page).to have_content "Users' house"
  end
end
