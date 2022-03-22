# frozen_string_literal: true

require_relative 'database_connection'

# Property class
class Property
  attr_reader :id, :title, :description, :address, :price, :image_url
  
  def initialize(id:, title:, description:, address:, price:, image_url:)
    @id = id
    @title = title
    @description = description
    @address = address
    @price = price
    @image_url = image_url
  end

  class << self
    def all
      database_connection(select_all_query)
    end

    def find(id)
      database_connection(find_query, [id])
    end
    
    private

    def select_all_query
      'SELECT * FROM properties;'
    end

    def find_query
      'SELECT * FROM properties WHERE id = $1;'
    end

    def database_connection(query, params = nil)
      DatabaseConnection.connect
      params.nil? ? DatabaseConnection.request(query) : DatabaseConnection.safe_request(query, params)
      DatabaseConnection.property_response
    end
  end
end
