class RoomsController < ApplicationController
  get '/rooms' do
    "You are logged in #{session[:email]}"
  end
end
