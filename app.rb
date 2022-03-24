# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/reloader'
require './lib/booking'
require './lib/user'
require './lib/property'

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

  get '/:id/booking' do
    @property = Property.find(params[:id]).first
    @user = User.find(session[:user_id]).first
    erb :booking
  end

  get '/create_listing' do
    @user = User.find(session[:user_id]).first
    erb :create_listing
  end

  post '/process_listing' do
    @user = User.find(session[:user_id]).first
    @property = Property.create(title: params[:title],
      description: params[:description],
      address: params[:address],
      price: params[:price],
      image_url: params[:image_url]).first
    redirect '/properties'
  end

  get '/profile' do
    @user = User.find(session[:user_id]).first
    erb :profile
  end

  get '/sign_in' do
    erb :sign_in
  end

  post '/process_sign_in' do
    @user = User.log_in(username: params[:username], password: params[:pwd])
    # if @user.first.password == params[:pwd]
      session[:user_id] = @user.first.id
      redirect '/properties'
    # else
    #   # flash[:notice] = 'Please check your email or password.'
    #   redirect('/sign_in')
    # end
    # user = User.authenticate(username: params[:username], password: params[:password])
    # if user  
    #   session[:user_id] = user.id
    #   redirect '/properties'
    # else
    #   flash[:notice] = 'Please check your email or password.'
    #   redirect('/sign_in')
    # end
  end

  get '/sign_out' do
    session.clear
    redirect('/properties')
  end

  get '/sign_up' do
    erb :sign_up
  end

  post '/process_sign_up' do
    User.create(username: params[:username], password: params[:pwd], email: params[:email])
    # (from Jonny) storing user ID for welcoming user by name on /properties
    # session[:user_id] = user.id
    redirect '/properties'
  end

  run! if app_file == $PROGRAM_NAME
end