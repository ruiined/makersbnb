# frozen_string_literal: true

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
    result = DatabaseConnection.query("SELECT * FROM properties;")
    result.map do |property|
      Property.new(id: property['id'], title: property['title'], description: property['description'], address: property['address'], price: property['price'], image_url: property['image_url'])
    end
  end
end