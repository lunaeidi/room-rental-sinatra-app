class SessionsController < ApplicationController
  get '/login' do
    erb :"sessions/login.html"
  end
  post '/sessions' do
    sessions[:email]= params[:email]
    redirec to '/rooms'
  end
  get '/logout' do
    session.clear
    redirect to '/login'
  end
end
