# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/reloader'
require './lib/booking'

# MakersBnB Application
class MakersBnB < Sinatra::Base
  configure :development do
    # :nocov:
    register Sinatra::Reloader
    # :nocov:
  end

  get '/' do
    erb(:index)
  end

  get '/properties' do
    erb(:properties)
  end

  get '/properties/:id' do
    @property_id = params[:id]
    erb(:'properties/book')
  end

  run! if app_file == $PROGRAM_NAME
end