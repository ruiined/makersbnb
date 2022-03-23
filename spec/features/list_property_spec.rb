# frozen_string_literal: true

feature 'verified users can list a space' do
    scenario 'signed-in users can add a property to rent' do
    visit('/')
    click_on 'Login'
    fill_in 'email', with: 'email'
    fill_in 'pwd', with: 'password'
    click_button 'submit'

    click_button 'list_a_space'
    expect(current_path).to eq('/properties/new')
    expect(page).to have_text('List a Property')
    expect(page).to have_field('name')
    expect(page).to have_field('description')
    expect(page).to have_field('price_per_night')
    expect(page).to have_field('available_from')
    expect(page).to have_field('available_to')
    expect(page).to have_button('list_property')

    fill_in 'name', with: 'new listing'
    fill_in 'description', with: 'description'
    fill_in 'price_per_night', with: '100'
    select '22/12/22', from: 'available_from'
    select '23/12/22', from: 'available_to'
    click_button 'submit_listing'

    expect(current_path).to eq('/properties')
    expect(page).to have_text('new listing')
    expect(page).to have_no_button('submit_listing')
  end
end

