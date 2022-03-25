# frozen_string_literal: true

require 'user'

describe User do
  subject(:user) { User }
  subject(:all_users) { User.all }

  let(:create_user) do
    User.create(
      username: 'bigfatden',
      password: 'Password123',
      email: 'bigfatden69@gmail.com'
    )
  end

  describe '.all' do
    it 'returns an empty array' do
      expect(all_users).to be_an_instance_of(Array)
      expect(all_users).to be_empty
    end

    it 'returns all properties' do
      create_user

      expect(all_users.length).to eq 1
      expect(all_users.first).to be_a User
      expect(all_users.first.id.to_i).to be_kind_of(Integer)
      expect(all_users.first.username).to eq 'bigfatden'
      expect(all_users.first.password).to eq 'Password123'
      expect(all_users.first.email).to eq 'bigfatden69@gmail.com'
    end
  end

  describe '.find' do
    it 'finds a user using the id' do
      found_user = user.find(create_user.first.id)
      expect(found_user.first.username).to eq 'bigfatden'
    end
    
    xit 'returns nil if there is no ID given' do
      expect(User.find(nil)).to eq nil
    end
   
  end

  describe '.create' do
    it 'adds a user to the database' do
      create_user
      expect(all_users.first.username).to eq 'bigfatden'
      expect(all_users.first.password).to eq 'Password123'
      expect(all_users.first.email).to eq 'bigfatden69@gmail.com'
    end
    xit 'hashes the password using BCrypt' do
      expect(BCrypt::Password).to receive(:create).with('password123')
  
      User.create(username: 'Diego', email: 'test@example.com', password: 'password123')
    end
  end

  describe '.delete' do
    it 'deletes a user from the database' do
      create_user
      user.delete(create_user.first.id)
      expect(all_users).to be_empty
    end
  end

  describe '.log_in' do
    it 'allows a user to log in with username and password' do
      create_user
      expect { user.log_in('bigfatden', 'Password123' }.not_to raise_error
      expect { user.log_in('blah', 'Password123' }.to raise_error
      expect { user.log_in('bigfatden', 'wrong_password' }.to raise_error
    end
  end
end
