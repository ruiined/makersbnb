# frozen_string_literal: true

def log_in
  visit('/')
  click_on 'Login'
  fill_in 'email', with: 'email'
  fill_in 'pwd', with: 'password'
  click_button 'submit'
end
