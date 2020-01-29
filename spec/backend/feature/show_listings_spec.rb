feature "showing listings" do
  scenario "it includes our test listing" do
    visit('/')
    expect(page).to have_content 'Test listing 1'
    expect(page).to have_content 'test-username'
  end
end
