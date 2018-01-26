require 'sinatra'

class NycSchoolFoodCalApp < Sinatra::Base

  get '/' do
    runner = NycSchoolFoodCal::Runner.new(data_file_path: File.expand_path('data'))

    response = runner.run(calendar: params[:calendar], month: params[:month], day: params[:day])

    {content: {menu: response, calendar: params[:calendar], month: params[:month], day: params[:day]}}.to_json
  end

end
