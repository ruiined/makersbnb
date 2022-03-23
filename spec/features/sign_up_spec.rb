# frozen_string_literal: true

feature 'users can sign up' do
  scenario 'users can enter a username and password which will be saved for further verification' do
    visit ('/')
    fill_in 'email', with: 'email'
    fill_in 'pwd', with: 'password'
    fill_in 'pwd_confirmation', with: 'password'
    click_button 'submit'
    expect(current_path).to eq('/properties')
    expect(page).to have_no_link('Sign Up', :href=>'/sign_up')
  end
end