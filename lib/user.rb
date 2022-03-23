# frozen_string_literal: true

require_relative 'database_connection'

# User class
class User
  attr_reader :id, :username, :password, :email
  
  def initialize(id:, username:, password:, email:)
    @id = id
    @username = username
    @password = password
    @email = email
  end

  class << self
    def all
      DatabaseConnection.run_user(select_all_query)
    end

    def find(id)
      # return nil unless id
      DatabaseConnection.run_user(find_query, [id])
    end

    def create(username:, password:, email:)
      encrypted_password = BCrypt::Password.create(password)
      DatabaseConnection.run_user(insert_query, [username, password, email])
    end

    def delete(id)
      DatabaseConnection.run_user(delete_query, [id])
    end

    def authenticate(username:, password:)
      return unless result.any?
      return unless BCrypt::Password.new(result[0]['password']) == password
      DatabaseConnection.run_user(authenticate_query, [username, password])
    end

    private

    def select_all_query
      'SELECT * FROM users;'
    end

    def find_query
      'SELECT * FROM users WHERE id = $1;'
    end

    def insert_query
      'INSERT INTO users (username, password, email)
       VALUES($1, $2, $3)
       RETURNING id, username, password, email;'
    end

    def authenticate_query
      'SELECT * FROM users WHERE username = $1'
    end

    def delete_query
      'DELETE FROM users WHERE id = $1;'
    end
  end
end
