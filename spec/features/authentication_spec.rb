feature 'authentication' do
  scenario 'a user can sign in' do
    create_user
    log_in
    expect(page).to have_content 'Let these potential bookings pique your curiosity'
  end

  xscenario 'a user sees an error if they get their username wrong' do
    create_user
    visit '/sign_in'
    fill_in(:username, with: 'Diogo')
    fill_in(:pwd, with: 'meow123')
    click_button('Login')

    expect(page).not_to have_content 'Let these potential bookings pique your curiosity'
    expect(page).to have_content 'Please check your email or password.'
  end

  xscenario 'a user sees an error if they get their password wrong' do
    create_user
    visit '/sign_in'
    fill_in(:username, with: 'Diego')
    fill_in(:pwd, with: 'wrongpassword')
    click_button('Login')

    expect(page).not_to have_content 'Let these potential bookings pique your curiosity'
    expect(page).to have_content 'Please check your email or password.'
  end

  scenario 'a user can sign out' do
    create_user
    log_in
    click_button('Sign out')

    expect(page).not_to have_link 'sign out'
    expect(page).to have_link 'sign in'
  end
end