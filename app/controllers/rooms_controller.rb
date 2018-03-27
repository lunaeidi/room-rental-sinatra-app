include FileUtils
class RoomsController < ApplicationController
  get '/rooms' do
    "You are logged in #{session[:email]}"
    @rooms= Room.all
    erb :'rooms/index'
  end
  get '/rooms/new' do
    #redirect_if_not_logged_in
    #@error_message= params[:error]
     #or
    # !if session[:email] && session[:email].empty?
  #  redirect "/login" and else ... erb
    erb :'rooms/new'
  end
  post '/rooms' do

    @room=Room.create(params)
    @room.user_id= current_user.id
    current_user.rooms << @room #should this be necessary?

    if params[:file]
    @filename = params[:pic][:filename]
   file = params[:pic][:tempfile]

   File.open("./public/#{@filename}", 'wb') do |f|
     f.write(file.read)
     #or
    #  cp(file.path, "public/#{@filename}")
    #  or

      #if params[:file]
#   @filename = params[:file][:filename]
#   tempfile = params[:file][:tempfile]
#   target = "public/#{@filename)"
#
#   File.open(target, 'wb') {|f| f.write tempfile.read }
# end
#  end

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

      #if @room= current_user.rooms.find(params[:id]) #current_user.rooms returns empty array
    @room= Room.find(params[:id])
#ALWAYS FINDING THE SAME ONE! THE ONE WITH ID:9
    if @room.user_id== current_user.id
      erb :'rooms/edit'

    else
      redirect '/rooms'
  end
end
patch '/rooms/:id' do
  @room= Room.find(params[:id]) #WHY IS IT ALWAYS GOING TO ID 9?

  @room.listing_title= params[:listing_title]
  @room.location= params[:location]
  @room.cost= params[:cost]
  @room.occupancy= params[:occupancy]
  @room.contact= params[:contact]
  @room.save
  redirect 'rooms/#{@room.id}'
end
delete '/rooms/:id/delete' do
  if !logged_in?
    redirect "/login"
  end
  #  room= current_user.rooms.find(params[:id]) #find_by wasnt working
@room=Room.find(params[:id])
  if room.user_id= current_user.id #or if current_user.rooms.include?(room)
      @room.delete
    redirect to '/rooms'
  else
    redirect '/rooms'
  end


end
end
