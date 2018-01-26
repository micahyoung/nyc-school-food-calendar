require 'sinatra'

get '/' do
  runner = NycSchoolFoodCal::Runner.new(data_file_path: File.expand_path('data'))

  runner.run(calendar: params[:calendar], month: params[:month], day: params[:day])
end
