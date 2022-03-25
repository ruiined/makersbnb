# frozen_string_literal: true

require_relative 'database_connection'
require 'bcrypt'

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
      DatabaseConnection.run_user(find_query, [id])
    end

    def log_in(username:, password:)
      DatabaseConnection.run_user(log_in_query, [username, password])
    end

    def create(username:, password:, email:)
      # encrypted_password = BCrypt::Password.create(password)
      DatabaseConnection.run_user(insert_query, [username, password, email])
    end

    def delete(id)
      DatabaseConnection.run_user(delete_query, [id])
    end

    def find_id(id)
      DatabaseConnection.run_user(find_id_query, [id])
    end

    # def authenticate(username:, password:)
    #   # return unless result.any?
    #   # BCrypt::Password.new(result[0]['password']) == password
    #   # decrypted_password = BCrypt::Password.new(encrypted_password)
    #   DatabaseConnection.run_user(authenticate_query, [username])
    #   # p result.first.password
    #   # p  BCrypt::Password.new(result.first.password)
    #   # p result.map { |user| password == BCrypt::Password.new(user.password)}
    #   # unless 
      
    # end

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

    def log_in_query
      'SELECT * FROM users WHERE username = $1 AND password = $2;'
    end

    def authenticate_query
      'SELECT * FROM users WHERE username = $1;'
    end

    def delete_query
      'DELETE FROM users WHERE id = $1;'
    end

    def find_id_query
      'SELECT id FROM users WHERE id = $1;'
    end
  end
end
