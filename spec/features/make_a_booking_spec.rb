feature 'make a booking' do
  scenario 'users can book an available property' do
    sign_in
    expect(page).to have_button('book_test_property')
    click_button(name: 'book_test_property')

    expect(current_path).to eq("/properties/#{property.id}")
    expect(page).to have_text('test_property')
    expect(page).to have_text('£_price_per_night')
    expect(page).to have_xpath(image url)
    expect(page).to have_button(name: 'submit')
    #expect(page).to have a calendar
    #use capybara to select date from calendar
    click_button(name: 'submit')

    expect(current_path).to eq("/properties/#{property.id}/booking_confirmation")
    expect(page).to have_text("Booking succesful!")
  end
end
