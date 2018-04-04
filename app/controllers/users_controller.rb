require 'sinatra/base'
require 'rack-flash'
class UsersController < ApplicationController
  get '/login' do
    erb :"users/login"
  end

  post '/login' do #check if a user with this email actuallyexists, if so, set the session
    user = User.find_by(:email => params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id 
      redirect "/rooms"
    else
        flash[:message] = "Invalid username or password" #this isnt showing up
      @error_message2= "Invalid username or password" #maybeshould differ where directs to whether invalid username or password
      redirect to '/signup' #should this direct to login or signup
    end
  end

  get '/logout' do
    session.clear
    redirect to '/login'
  end
  get '/signup' do
    #@error_message2= "Invalid username or password" does this need to go here ?

    if !session[:user_id]
    #  flash[:message] = "Username already exists" #does it go here on in post '/signup'. here it comes from beginning.
          @error_message = "Username already exists"
      erb :'users/signup'
    else
      redirect '/rooms'
    end
  end

  post '/signup' do

    if user=User.find_by_email(params[:email]) #make error message
      flash[:message] = "Username already exists"
      erb :'users/signup' #or redirect to error page that explains
    else
    @user = User.create(:email => params[:email], :password => params[:password])
    session[:user_id] = @user.id
    #need to decide where to redirect to. either 'users/home' or '/rooms'

    redirect "/rooms"
  end
  end
end
