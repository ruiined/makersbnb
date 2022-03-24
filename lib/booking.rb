# frozen_string_literal: true

require_relative 'database_connection'
require_relative 'property'
require_relative 'user'

# Booking Class
class Booking
  def initialize(id:, property_id:, user_id:)
    @id = id
    @property_id = property_id
    @user_id = user_id
  end

  class << self
    def all
      DatabaseConnection.run_booking(select_all_query)
    end

    def find(id)
      DatabaseConnection.run_booking(find_query, [id])
    end

    def create(property_id:, user_id:, start_date:, end_date:, guests:, comment:)
      DatabaseConnection.run_booking(insert_query, [property_id, user_id, start_date, end_date, guests, comments])
    end

    def delete(id)
      DatabaseConnection.run_booking(delete_query, [id])
    end

    private

    def select_all_query
      'SELECT * FROM bookings;'
    end

    def find_query
      'SELECT * FROM bookings WHERE id = $1;'
    end

    def insert_query
      'INSERT INTO bookings (property_id, user_id, start_date, end_date, guests, comment)
       VALUES($1, $2, $3, $4, $5, $6)
       RETURNING id, property_id, user_id, start_date, end_date, guests, comment;'
    end

    def delete_query
      'DELETE FROM bookings WHERE id = $1;'
    end

end
