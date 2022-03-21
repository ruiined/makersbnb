require 'sinatra/base'
require 'sinatra/reloader'
require './lib/booking'

# Chitter Application
class MakersBnB < Sinatra::Base
  configure :development do
  # :nocov:
    register Sinatra::Reloader
  # :nocov:
  end

  get '/' do
  
  end

  run! if app_file == $PROGRAM_NAME
end
