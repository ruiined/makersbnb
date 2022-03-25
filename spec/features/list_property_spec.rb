# frozen_string_literal: true

feature 'create listing' do
  scenario 'signed-in user can access a form to list property' do
    create_user
    log_in
    click_link 'post a listing'

    expect(current_path).to eq('/create_listing')
    expect(page).to have_text('Create your listing')
    expect(page).to have_field('title')
    expect(page).to have_field('description')
    expect(page).to have_field('address')
    expect(page).to have_field('price')
    expect(page).to have_field('image_url')
    expect(page).to have_button('Submit')
  end

  xscenario 'signed-in user can post listing' do
    create_user
    log_in
    click_link 'post a listing'
    fill_in 'title', with: 'new listing'
    fill_in 'description', with: 'description'
    fill_in 'address', with: '100 Ball Street'
    fill_in 'price', with: '50'
    fill_in 'image_url', with: 'http://ball.street'
    click_button 'Submit'

    expect(current_path).to eq('/properties')
    expect(page).to have_text('new listing')
    expect(page).to have_no_button('submit_listing')
  end
end
