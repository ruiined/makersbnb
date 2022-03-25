# frozen_string_literal: true

require 'pg'

# Database Connection class
class DatabaseConnection
  class << self
    def run_property(query, params = nil)
      connect
      params.nil? ? request(query) : params_request(query, params)
      property_response
    end
    def run_user(query, params = nil)
      connect
      params.nil? ? request(query) : params_request(query, params)
      user_response
    end
    def run_booking(query, params = nil)
      connect
      params.nil? ? request(query) : params_request(query, params)
      booking_response
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
          host_id: property['host_id'],
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
          host_id: booking['host_id'],
          guest_id: booking['guest_id'],
          start_date: booking['start_date'],
          end_date: booking['end_date'],
          guests: booking['guests'],
          comment: booking['comment'],
          confirmed: booking['confirmed']
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
