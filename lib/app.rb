require 'sinatra/base'
require 'nyc_school_food_cal'

class NycSchoolFoodCalApp < Sinatra::Base

  helpers do
    def runner
      NycSchoolFoodCal::Runner.new(data_file_path: File.expand_path('data'))
    end
  end

  set :public_folder, 'public'

  get '/' do
      redirect '/index.html'
  end

  get '/api/v1/menus' do
    calendar, month, day = params[:calendar], params[:month], params[:day]
    response = runner.menu(calendar: calendar, month: month, day: day)

    content_type :json

    {content: {menu: response, calendar: calendar, month: month, day: day}}.to_json
  end

  get '/api/v1/calendars' do
    content_type :json

    response = runner.calendars

    {content: {calendars: response}}.to_json
  end

end
