# frozen_string_literal: true

require 'property'

describe Property do
  describe '.all' do
    subject(:property) { Property }
    subject(:all_properties) { Property.all }

    it 'returns an empty array' do
      expect(all_properties).to be_an_instance_of(Array)
      expect(all_properties).to be_empty
    end

    xit 'returns all properties' do
      connection = PG.connect(dbname: 'makersbnb_test')

      property = Property.new(id: 1, title: 'Bungalow', description: 'Small bungalow', address: '4 Nutt Square',
                              price: 10, image_url: 'http://nutt.nutt')
      Property.new(id: 1, title: 'Mansion', description: 'Massive mansion', address: '5 Nutt Square', price: 1000,
                   image_url: 'http://nutt2.nutt2')

      properties = Property.all

      expect(properties.length).to eq 2
      expect(properties.first).to be_a Property
      expect(properties.first.id).to eq property.id
      expect(properties.first.title).to eq 'Bungalow'
      expect(properties.last.address).to eq '5 Nutt Square'
    end
  end
end
