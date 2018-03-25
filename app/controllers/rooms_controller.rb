class RoomsController < ApplicationController
  get '/rooms' do
    "You are logged in #{session[:email]}"
  end
  get 'rooms/new' do
    #redirect_if_not_logged_in
    #@error_message= params[:error]
     #or
    # !if session[:email] && session[:email].empty?
  #  redirect "/login" and else ... erb
    erb :'rooms/new'
  end
  get '/posts/:id/edit' do
    #redirect_if_not_logged_in
    #@error_message= params[:error]
    #room= Room.find(params[:id])
    #erb :'rooms/edit'
    if !logged_in?
      redirect "/login"
    else
      room= current_user.rooms.find_by(params[:id])
    if room.user_id= current_user.id
      erb :'rooms/edit'
    else
      redirect '/rooms'

  end
end
