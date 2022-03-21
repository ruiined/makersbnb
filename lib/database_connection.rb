# frozen_string_literal: true
require 'pg'
require_relative 'property'
require_relative 'user'

# Database Connection class
class DatabaseConnection
  class << self

    def all
      connect
      request('SELECT * FROM properties')
      property_response
    end

    def connect 
      @connection = PG.connect(dbname: database_name)
    end

    def request(query)
      @request = @connection.exec(query)
    end

    def safe_request(query)
      @request = @connection.exec_params(query, params)
    end

    def property_response
      @request.each do | property |
        Property.new(
          id: property['id'],
          title: property['title'],
          description: property['description'],
          address: property['address'],
          price: property['price'],
          image_url: property['image_url']
        )
      end
    end

    def user_response
      @request.each do | user |
        User.new(
          id: user['id'],
          username: user['username'],
          password: user['password'],
          email: user['email'],
        )
      end
    end

    def booking_response
      @request.each do | booking |
        Booking.new(
          id: booking['id'],
          property_id: booking['property_id'],
          user_id: booking['user_id']
        )
      end
    end
    
    private

    def database_name
      testing? ? 'makersbnb_test' : 'makersbnb'
    end

    def testing?
      ENV['RACK_ENV'] == 'test'
    end
  end
end
