# frozen_string_literal: true

require 'booking'

describe Booking do
  subject(:booking) { Booking }
  subject(:all_bookings) { Booking.all }

  let(:create_booking) do
    Booking.create(
      property_id: 1,
      host_id: 1,
      guest_id: 2,
      start_date: 12/12/2022,
      end_date: 13/12/2022,
      guests: 2,
      comment: 'Hello'
    )
  end

  describe '.all' do
    it 'returns an empty array' do
      expect(all_bookings).to be_an_instance_of(Array)
      expect(all_bookings).to be_empty
    end

    it 'returns all bookings' do
      create_booking

      expect(all_bookings.length).to eq 1
      expect(all_bookings.first).to be_a Booking
      expect(all_bookings.first.id.to_i).to be_kind_of(Integer)
      expect(all_bookings.first.guests).to eq 2
      expect(all_bookings.last.comment).to eq 'Hello'
    end
  end

  describe '.find' do
    it 'finds a booking using the id' do
      found_booking = booking.find(create_booking.first.id)
      expect(found_booking.first.property_id.to_i).to eq 1
      expect(found_booking.first.host_id.to_i).to eq 1
      expect(found_booking.first.guest_id.to_i).to eq 2
      expect(found_booking.first.guests.to_i).to eq 2
      expect(found_booking.first.comment).to eq 'Hello'
    end
  end

  describe '.create' do
    it 'adds a booking to the database' do
      create_booking
      expect(all_bookings.first.property_id.to_i).to eq 1
      expect(all_bookings.first.host_id.to_i).to eq 1
      expect(all_bookings.first.guest_id.to_i).to eq 2
      expect(all_bookings.first.guests.to_i).to eq 2
      expect(all_bookings.first.comment).to eq 'Hello'
    end
  end
  
  describe '.delete' do
    it 'deletes a booking from the database' do
      create_booking
      booking.delete(create_booking.first.id)
      expect(all_bookings).to be_empty
    end
  end
end
