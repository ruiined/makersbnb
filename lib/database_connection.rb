# frozen_string_literal: true

require 'pg'

# Database Connection class
class DatabaseConnection
  class << self
    def run(query, params = nil)
      connect
      params.nil? ? request(query) : params_request(query, params)
      response
    end

    private

    def connect
      @connection = PG.connect(dbname: database_name)
    end

    def request(query)
      @request = @connection.exec(query)
    end

    def params_request(query, params)
      @request = @connection.exec_params(query, params)
    end

    def response
      if Property
        property_response
      elsif User
        user_response
      elsif Booking
        booking_response
      end
    end

    def property_response
      @request.map do |property|
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
      @request.map do |user|
        User.new(
          id: user['id'],
          username: user['username'],
          password: user['password'],
          email: user['email']
        )
      end
    end

    def booking_response
      @request.map do |booking|
        Booking.new(
          id: booking['id'],
          property_id: booking['property_id'],
          user_id: booking['user_id']
        )
      end
    end

    def database_name
      testing? ? 'makersbnb_test' : 'makersbnb'
    end

    def testing?
      ENV['RACK_ENV'] == 'test'
    end
  end
end
