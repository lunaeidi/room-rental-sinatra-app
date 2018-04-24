require 'sinatra/base'
require 'rack-flash'
class UsersController < ApplicationController
  get '/login' do
    erb :"users/login"
  end

  post '/login' do
    user = User.find_by(:email => params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/rooms"
    else
        flash[:message] = "Invalid username or password"
      @error_message2= "Invalid username or password"
      redirect to '/signup'
    end
  end

  get '/logout' do
    session.clear
    redirect to '/login'
  end
  get '/signup' do
    if !session[:user_id]
        erb :'users/signup'
    else
      redirect '/rooms'
    end
  end

  post '/signup' do

    if user=User.find_by_email(params[:email])
      flash[:message] = "Username already exists"
      erb :'users/signup'
    else
    @user = User.create(:email => params[:email], :password => params[:password])
    session[:user_id] = @user.id
      redirect "/rooms"
  end
  end
end
