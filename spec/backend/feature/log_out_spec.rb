feature 'logging out' do
  scenario 'it allows a user to logut', js: true do
    login

    find('.drop-down-container').hover
    find(:xpath, "//a[@href='/?logout=true']").click
    expect(page).to_not have_content "Welcome User"
  end
end
