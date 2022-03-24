# frozen_string_literal: true
def create_user
  User.create(username: 'Diego', email: 'test@example.com', password: 'meow123')
end

def log_in
  visit('/')
  click_link 'sign in'
  fill_in 'username', with: 'Diego'
  fill_in 'pwd', with: 'meow123'
  click_button 'Login'
end
