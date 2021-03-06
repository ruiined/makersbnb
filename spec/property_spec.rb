# frozen_string_literal: true

require 'property'

describe Property do
  subject(:property) { Property }
  subject(:all_properties) { Property.all }

  let(:create_property) do
    Property.create(
      title: 'Bungalow',
      host_id: 1,
      description: 'Small bungalow',
      address: '4 Nutt Square',
      price: 10,
      image_url: 'http://nutt.nutt.com'
    )
  end

  describe '.all' do
    it 'returns an empty array' do
      expect(all_properties).to be_an_instance_of(Array)
      expect(all_properties).to be_empty
    end

    it 'returns all properties' do
      create_property

      expect(all_properties.length).to eq 1
      expect(all_properties.first).to be_a Property
      expect(all_properties.first.id.to_i).to be_kind_of(Integer)
      expect(all_properties.first.title).to eq 'Bungalow'
      expect(all_properties.last.address).to eq '4 Nutt Square'
    end
  end

  describe '.find' do
    it 'finds a property using the id' do
      found_property = property.find(create_property.first.id)
      expect(found_property.first.title).to eq 'Bungalow'
    end
  end

  describe '.create' do
    it 'adds a property to the database' do
      create_property
      expect(all_properties.first.title).to eq 'Bungalow'
      expect(all_properties.first.description).to eq 'Small bungalow'
      expect(all_properties.first.address).to eq '4 Nutt Square'
      expect(all_properties.first.price).to eq '10'
      expect(all_properties.first.image_url).to eq 'http://nutt.nutt.com'
    end
  end

  describe '.delete' do
    it 'deletes a property from the database' do
      create_property
      property.delete(create_property.first.id)
      expect(all_properties).to be_empty
    end
  end

  describe '.find_owner' do
    it 'finds the host id of a property' do
      found_host = property.find_owner(create_property.first.host_id)
      expect(found_host.host_id.to_i).to eq 1
    end
  end

  describe '.find_id' do
    it 'finds the id of a property' do
      create_property
      found_property_id = property.find_id()
      expect(create_property.find_id).to eq create_property.first.id
    end
  end
end
