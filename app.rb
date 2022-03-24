# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/reloader'
require './lib/booking'
require './lib/user'

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
    # (from Jonny) if welcoming the user (would have to enable sessions?):
    # stored user ID in POST 'process/sign_up' below
    # @user = User.find(session[:user_id])
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

  post '/process_booking_request' do
    Booking.create(property_id:,
      host_id:,
      guest_id:,
      start_date: params[:start_date],
      end_date: params[:end_date],
      guests: params[:guests],
      comment: params[:comment],
      confirmation:)
    redirect '/booking_request_received'
  end

  get 'booking_request_received' do
    erb :booking_request_received
  end

  get '/create_listing' do
    erb :create_listing
  end

  post '/process_listing' do
    @property = Property.create(title: params[:title],
      description: params[:description],
      address: params[:address],
      price: params[:price],
      image_url: params[:image_url])
    redirect '/properties'
  end

  get '/:user_id/profile' do
    @user = User.find(params[:user_id])
    erb :profile
  end

  get '/sign_in' do
    erb :sign_in
  end

  post '/process_sign_in' do
    user = User.authenticate(username: params[:username], password: params[:password])
    if user  
      session[:user_id] = user.id
      redirect '/properties'
    else
      flash[:notice] = 'Please check your email or password.'
      redirect('/sign_in')
    end
  end

  get '/sign_out' do
    redirect '/properties'
  end

  post '/sessions/destroy' do
    session.clear
    flash[:notice] = 'You have signed out.'
    redirect('/sign_in')
  end

  get '/sign_up' do
    erb :sign_up
  end

  post '/process_sign_up' do
    User.create(username: params[:username], email: params[:email], password: params[:password])
    # (from Jonny) storing user ID for welcoming user by name on /properties
    # session[:user_id] = user.id
    redirect '/properties'
  end

  run! if app_file == $PROGRAM_NAME
end
