feature 'authentication' do
  scenario 'a user can sign in' do
    User.create(username: 'Diego', email: 'test@example.com', password: 'password123')

    visit '/sign_in'
    fill_in(:username, with: 'Diego')
    fill_in(:pwd, with: 'password123')
    click_button('Sign in')

    expect(page).to have_content 'Let these potential bookings pique your curiosity'
  end

  scenario 'a user sees an error if they get their username wrong' do
    User.create(username: 'Diego', email: 'test@example.com', password: 'password123')

    visit '/sign_in'
    fill_in(:username, with: 'Diogo')
    fill_in(:pwd, with: 'password123')
    click_button('Sign in')

    expect(page).not_to have_content 'Let these potential bookings pique your curiosity'
    expect(page).to have_content 'Please check your email or password.'
  end

  scenario 'a user sees an error if they get their password wrong' do
    User.create(username: 'Diego', email: 'test@example.com', password: 'password123')

    visit '/sign_in'
    fill_in(:username, with: 'Diego')
    fill_in(:pwd, with: 'wrongpassword')
    click_button('Sign in')

    expect(page).not_to have_content 'Let these potential bookings pique your curiosity'
    expect(page).to have_content 'Please check your email or password.'
  end

  scenario 'a user can sign out' do
    User.create(username: 'Diego', email: 'test@example.com', password: 'password123')

    visit '/sign_in'
    fill_in(:username, with: 'Diego')
    fill_in(:pwd, with: 'password123')
    click_button('Sign in')

    click_button('Sign out')

    expect(page).not_to have_content 'Let these potential bookings pique your curiosity'
    expect(page).to have_content 'You have signed out.'
  end
end