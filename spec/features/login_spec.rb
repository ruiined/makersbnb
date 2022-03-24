# frozen_string_literal: true

feature 'users can log in' do
  scenario 'users can enter their name and password to log in' do
    create_user
    log_in
    expect(current_path).to eq('/properties')
  end
end