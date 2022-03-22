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
end
