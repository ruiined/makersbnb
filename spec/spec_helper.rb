# frozen_string_literal: true

require 'pg'

require 'simplecov'
require 'simplecov-console'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
                                                                 SimpleCov::Formatter::Console
                                                               ])
SimpleCov.start

ENV['RACK_ENV'] = 'test'

require File.join(File.dirname(__FILE__), '..', 'app.rb')

require 'capybara'
require 'capybara/rspec'
require 'rspec'
require 'features/web_helpers'
# require_relative 'db_setup'

Capybara.app = MakersBnB

RSpec.configure do |config|
  config.before(:each) do
    connection = PG.connect(dbname: 'makersbnb_test')

    connection.exec('TRUNCATE properties, users, bookings;')
  end

  config.after(:suite) do
    puts
    puts "\e[33mRubocop it!\e[0m"
  end
end
