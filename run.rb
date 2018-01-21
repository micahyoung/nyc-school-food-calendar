#!/usr/bin/env ruby
$:.unshift File.dirname(__FILE__) + '/lib'

require 'nyc_lunch_cal'

if __FILE__ == $0
  puts NycLunchCal::Runner.new.run(*ARGV)
end
