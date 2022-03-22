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
    @properties = Property.all
    erb :index
  end

  get '/:id/property' do
    @property = params[:id]
    erb :'property'
  end

  run! if app_file == $PROGRAM_NAME
end
