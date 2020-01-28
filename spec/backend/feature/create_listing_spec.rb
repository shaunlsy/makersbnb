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
    fill_in("list_name", with: "Users house")
    fill_in("short_description", with: "My house is superb!")
    fill_in("price_per_night", with: "150")
    click_button "Add listing"
    expect(page).to have_content "Users house"
    expect(page).to have_content "My house is superb!"
    expect(page).to have_content "£150"
  end
end
