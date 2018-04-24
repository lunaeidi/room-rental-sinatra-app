require 'sinatra/base'
require 'rack-flash'
include FileUtils
class RoomsController < ApplicationController
  get '/rooms' do

    @rooms= Room.all
    erb :'rooms/index'
  end
  get '/rooms/new' do


  if logged_in?
      erb :'rooms/new'
    else
      flash[:message]= "You need to be logged in to make a listing."
      redirect "/login"
    end
  end
  post '/rooms' do
current_user.rooms.create(params)

    # @room=Room.create(params)
    # @room.user_id= current_user.id
    # current_user.rooms << @room



    @filename = params[:pic][:filename]
file = params[:pic][:tempfile]

File.open("./public/#{@filename}", 'wb') do |f|
  f.write(file.read)
end
session[:filename]= params[:pic][:filename]
array= @room.pic.split(",")[0][14..-2]
    redirect "/rooms/#{@room.id}"
  end

  get '/rooms/:id' do
    @room= Room.find(params[:id])
  erb :'/rooms/show'
  end

  get '/rooms/:id/edit' do
        if !logged_in?
      redirect "/login"
    end
    @room= Room.find(params[:id])

    if @room.user_id== current_user.id
      erb :'rooms/edit'

    else
      flash[:message]= "You don't have permission to do that."
      redirect '/rooms'
  end
end

patch '/rooms/:id' do
  @room= Room.find(params[:id])
  @room.listing_title= params[:listing_title]
  @room.location= params[:location]
  @room.cost= params[:cost]
  @room.occupancy= params[:occupancy]
  @room.contact= params[:contact]
  @room.save
  redirect "rooms/#{@room.id}" #had to use double quotes with interpolation
end
delete '/rooms/:id/delete' do
  if !logged_in?
    redirect "/login"
  end

@room=Room.find(params[:id])
  if @room.user_id= current_user.id
      @room.delete
    redirect to '/rooms'
  else
    redirect '/rooms'
  end


end
end
