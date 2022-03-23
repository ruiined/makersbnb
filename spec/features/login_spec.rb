# frozen_string_literal: true

feature 'users can log in' do
  scenario 'users can enter their name and password to log in' do
    visit('/')
    click_on 'Login'
    fill_in 'email', with: 'email'
    fill_in 'pwd', with: 'password'
    click_button 'submit'
    expect(current_path).to eq('/properties')
  end
end