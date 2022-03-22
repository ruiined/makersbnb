feature "view properties" do
  scenario "User can view a list of available properties" do
    sign_in
    expect(current_path).to eq("/properties")
    expect(page).to have_text('test_property')
  end
end
