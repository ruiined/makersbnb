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
      DatabaseConnection.run(select_all_query)
    end

    def find(id)
      DatabaseConnection.run(find_query, [id])
    end

    def create(title:, description:, address:, price:, image_url:)
      DatabaseConnection.run(insert_query, [title, description, address, price, image_url])
    end

    def delete(id)
      DatabaseConnection.run(delete_query, [id])
    end

    private

    def select_all_query
      'SELECT * FROM properties;'
    end

    def find_query
      'SELECT * FROM properties WHERE id = $1;'
    end

    def insert_query
      'INSERT INTO properties (title, description, address, price, image_url)
       VALUES($1, $2, $3, $4, $5) 
       RETURNING id, title, description, address, price, image_url;'
    end

    def delete_query
      'DELETE FROM properties WHERE id = $1;'
    end
  end
end
