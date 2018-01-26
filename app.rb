require 'sinatra'

get '/' do
  "Date: #{params[:month]}, #{params[:day]}"
end
