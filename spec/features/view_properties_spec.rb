# frozen_string_literal: true

feature 'view properties' do
  xscenario 'User can view a list of available properties' do
    visit('/')
    click_on 'Login'
    fill_in 'email', with: 'email'
    fill_in 'pwd', with: 'password'
    click_button 'submit'
    expect(current_path).to eq('/properties')
    expect(page).to have_text('test_property')
  end
end
