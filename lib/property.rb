# frozen_string_literal: true
require_relative 'database_connection'

class Property
  def initialize(id:, title:, description:, address:, price:, image_url:)
    @id = id
    @title = title
    @description = description
    @address = address
    @price = price
    @image_url = image_url
  end

  def self.all
reallyreallygoodbranchnameyea
    DatabaseConnection.connect
    DatabaseConnection.request("SELECT * FROM properties;")
    DatabaseConnection.property_response 
    end
  end
end
