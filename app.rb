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
reallyreallygoodbranchnameyea
    @properties = Property.all
    erb :index
  end

  get '/:id/property' do
    @property = params[:id]
    erb :'property'

    erb(:index)
  end

  get '/properties' do
    erb(:properties)
  end

  get '/properties/:id' do
    @property_id = params[:id]
    erb(:'properties/book')
main
  end

  run! if app_file == $PROGRAM_NAME
end
