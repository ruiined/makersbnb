# frozen_string_literal: true

feature 'make a booking' do
  xscenario 'users can book an available property' do
    visit('/')
    click_on 'Login'
    fill_in 'email', with: 'email'
    fill_in 'pwd', with: 'password'
    click_button 'submit'
    expect(page).to have_button('book_test_property')
    click_button(name: 'book_test_property')

    expect(current_path).to eq("/properties/#{property.id}")
    expect(page).to have_text('test_property')
    expect(page).to have_text('100')
    expect(page).to have_xpath('http//image_url')
    expect(page).to have_button(name: 'submit')
    # expect(page).to have a calendar
    # use capybara to select date from calendar1
    #use capybara to select date from calendar2
    click_button(name: 'submit')

    expect(current_path).to eq("/properties/#{property.id}/booking_requested")
    expect(page).to have_text('Booking requested!')
  end
end
