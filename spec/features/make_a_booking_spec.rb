# frozen_string_literal: true

feature 'make a booking' do
  scenario 'user can view an available property' do
    user = User.create(username: 'Diego', email: 'cat@cat.com', password: 'meow123')

    visit('/')
    click_link 'sign in'
    fill_in 'username', with: 'Diego'
    fill_in 'pwd', with: 'meow123'
    click_button 'Login'
    expect(page).to have_link('View property')
  end
  
  xscenario 'user can book an available property' do
    user = User.create(username: 'Diego', email: 'cat@cat.com', password: 'meow123')

    visit('/')
    click_link 'sign in'
    fill_in 'username', with: 'Diego'
    fill_in 'pwd', with: 'meow123'
    click_button 'Login'
    click_link 'View property'
    click_link 'Book'
    
  end
end
