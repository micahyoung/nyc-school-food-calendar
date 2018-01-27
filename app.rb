$:.unshift File.dirname(__FILE__) + '/lib'

require 'sinatra/base'
require 'nyc_school_food_cal'

class NycSchoolFoodCalApp < Sinatra::Base

  helpers do
    def runner
      NycSchoolFoodCal::Runner.new(data_file_path: File.expand_path('data'))
    end
  end

  get '/' do
    calendar, month, day = params[:calendar], params[:month], params[:day]
    response = runner.run(calendar: calendar, month: month, day: day)

    content_type :json

    {content: {menu: response, calendar: calendar, month: month, day: day}}.to_json
  end

end

NycSchoolFoodCalApp.run!
