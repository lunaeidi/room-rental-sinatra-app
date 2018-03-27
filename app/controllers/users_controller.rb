class UsersController < ApplicationController
  get '/login' do
    erb :"users/login"
  end

  post '/login' do #check if a user with this email actuallyexists, if so, set the session
    user = User.find_by(:email => params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id #or session[:email] = user.email
      redirect "/rooms"
    else
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

    if user=User.find_by_email(params[:email]) #make error message
      erb :'users/signup' #or redirect to error page that explains
    else
    @user = User.create(:email => params[:email], :password => params[:password])
    session[:user_id] = @user.id
    #need to decide where to redirect to. either 'users/home' or '/rooms'
    redirect "/rooms"
  end
  end
end
