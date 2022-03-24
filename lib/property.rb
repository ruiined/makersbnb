# frozen_string_literal: true

require_relative 'database_connection'

# Property class
class Property
  attr_reader :id, :owner_id, :title, :description, :address, :price, :image_url

  def initialize(id:, owner_id:, title:, description:, address:, price:, image_url:)
    @id = id
    @owner_id = owner_id
    @title = title
    @description = description
    @address = address
    @price = price
    @image_url = image_url
  end

  class << self
    def all
      DatabaseConnection.run_property(select_all_query)
    end

    def find(id)
      DatabaseConnection.run_property(find_query, [id])
    end

    def create(title:, description:, address:, price:, image_url:)
      DatabaseConnection.run_property(insert_query, [owner_id, title, description, address, price, image_url])
    end

    def delete(id)
      DatabaseConnection.run_property(delete_query, [id])
    end

    def find_owner(id)
      DatabaseConnection.run_property(find_owner_query, [id])
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
       VALUES($1, $2, $3, $4, $5, $6)
       RETURNING id, owner_id, title, description, address, price, image_url;'
    end

    def delete_query
      'DELETE FROM properties WHERE id = $1;'
    end

    def find_owner_query
      'SELECT owner_id FROM properties WHERE id = $1;'
    end
  end
end
