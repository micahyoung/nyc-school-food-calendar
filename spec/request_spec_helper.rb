require 'rack/test'
require 'rspec'

ENV['RACK_ENV'] = 'test'

require_relative '../lib/app'

module RSpecMixin
  include Rack::Test::Methods
  def app() NycSchoolFoodCalApp end
end

# For RSpec 2.x and 3.x
RSpec.configure { |c| c.include RSpecMixin }
