# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.0.0'

gem 'pg'
gem 'rack'
gem 'sinatra'
gem 'sinatra-contrib'
gem "sinatra-flash"
gem 'webrick'
gem 'bcrypt'

group :test do
  gem 'capybara'
  gem 'rspec'
  gem 'simplecov', require: false
  gem 'simplecov-console', require: false
  gem 'webdrivers', '~> 5.0', require: false
end

group :development, :test do
  gem 'rubocop', '1.20'
end
