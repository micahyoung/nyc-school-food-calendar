require 'rspec'
require_relative '../lib/nyc_school_food_cal'

def fixture_path(path)
  File.dirname(__FILE__) + '/fixtures/' + path
end

RSpec.configure do |c|
  c.before { allow(NycSchoolFoodCal::Logger).to receive(:warn) }
end
