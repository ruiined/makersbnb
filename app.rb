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
    redirect '/properties'
  end

  get '/properties' do
    @properties = Property.all
    erb(:properties)
  end

  get '/:id/property' do
    @property = Property.find(params[:id])
    erb :property
  end

  get '/:id/booking' do
    @property = Property.find(params[:id])
    erb :booking
  end

  get '/:user_id/profile' do
    @user = User.find(params[:user_id])
    erb :profile
  end

  get '/sign_in' do
    erb :sign_in
  end

  post '/process_sign_in' do
    redirect '/properties'
  end

  get '/sign_out' do
    redirect '/properties'
  end

  get '/sign_up' do
    erb :sign_up
  end

  post '/process_sign_up' do
    redirect '/properties'
  end

  run! if app_file == $PROGRAM_NAME
end
