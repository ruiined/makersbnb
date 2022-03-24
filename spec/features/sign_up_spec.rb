feature 'registration' do
  scenario 'a user can sign up' do
    visit '/sign_up'
    fill_in('username', with: 'Diego')
    fill_in('pwd', with: 'password123')
    fill_in('email', with: 'test@example.com')
    click_button('Sign Up')
    
    expect(page).to have_link "Diego's profile"
    expect(page).to have_content "Let these potential bookings pique your curiosity"
  end
end