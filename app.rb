# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/flash'
require './lib/booking'
require './lib/user'
require './lib/property'
require './lib/database_connection'

# MakersBnB Application
class MakersBnB < Sinatra::Base
  configure :development do
    # :nocov:
    register Sinatra::Reloader
    # :nocov:
  end

enable :sessions
  get '/' do
    redirect '/properties'
  end

  get '/properties' do
    # (from Jonny) if welcoming the user (would have to enable sessions?):
    # stored user ID in POST 'process/sign_up' below
    # @user = User.find(session[:user_id])
    @properties = Property.all
    @user = User.find(session[:user_id]).first
    erb(:properties)
  end

  get '/:id/property' do
    @property = Property.find(params[:id]).first
    @user = User.find(session[:user_id]).first
    erb :property
  end
  
  get '/:id/booking_request' do
    @property = Property.find(params[:id]).first
    @user = User.find(session[:user_id]).first
    
    erb :booking
  end

  # TODO - get property id and host id parameters to work
  post '/process_booking_request' do
    hoster_id = Property.find(params[:property_id]).first.host_id
    guest_id = User.find(session[:user_id]).first.id
    booking = Booking.create(
      property_id: params[:property_id],
      host_id: hoster_id,
      guest_id: guest_id,
      start_date: params[:start_date],
      end_date: params[:end_date],
      guests: params[:guests],
      comment: params[:comment]
    )
    redirect '/booking_request_received'
  end

  get '/booking_request_received' do
    @booking = Booking.all.last
    erb :booking_request_received
  end
 
  get '/create_listing' do
    @user = User.find(session[:user_id]).first
    erb :create_listing
  end

  post '/process_listing' do
    user_id = User.find(session[:user_id]).first.id
    @property = Property.create(
      host_id: user_id,
      title: params[:title],
      description: params[:description],
      address: params[:address],
      price: params[:price],
      image_url: params[:image_url])
    redirect '/properties'
  end

  get '/profile' do
    @user = User.find(session[:user_id]).first
    @properties_all = Property
    @bookings_all = Booking
    @bookings = Booking.find_by_guest(session[:user_id])
    @properties = Property.find_by_host(session[:user_id])
    erb :profile
  end

  get ':user_id/requests_list' do
    @user = User.find(params[:user_id])
    erb :requests
  end

  get 'booking_evaluation' do
    @booking = Booking.find(params[:id])
    erb :booking_evaluation
  end

  # host accepts guest booking request - confirmation status changes from false to true in bookings table
  post 'process_booking_confirmation' do
    
  end

  # host rejects guest booking request - the booking is deleted from the table
  post 'process_booking_rejection' do
    
  end

  get '/sign_in' do
    erb :sign_in
  end

  post '/process_sign_in' do
    @user = User.log_in(username: params[:username], password: params[:pwd])
    # id = DatabaseConnection.run_user(
    #   "SELECT id 
    #   FROM users 
    #   WHERE username = $1 AND password = $2;", 
    #   [params[:username], params[:password]]
    # )
    # if id.first.num_tuples.zero?
    #   flash[:invalid_login] = "Invalid login</h4>"
    #   redirect '/sign_in'
    # else
      session[:user_id] = @user.first.id
      redirect '/properties'
  end

  get '/sign_out' do
    session.clear
    redirect('/properties')
  end

  get '/sign_up' do
    erb :sign_up
  end

  post '/process_sign_up' do
    @user = User.create(username: params[:username], password: params[:pwd], email: params[:email])
    session[:user_id] = @user.first.id
    redirect('/properties')
  end

  run! if app_file == $PROGRAM_NAME
end