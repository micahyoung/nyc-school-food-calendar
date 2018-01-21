#!/usr/bin/env ruby
$:.unshift File.dirname(__FILE__) + '/lib'

require 'nyc_school_food_cal'

if __FILE__ == $0
  puts NycSchoolFoodCal::Runner.new.run(*ARGV)
end
