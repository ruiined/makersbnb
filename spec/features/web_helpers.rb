def sign_in
  visit('/')
  fill_in 'username' with: 'username'
  fill_in 'password' with: 'password'
  click_button 'submit'
end