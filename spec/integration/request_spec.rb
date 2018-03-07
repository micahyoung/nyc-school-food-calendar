require 'spec_helper'
require 'request_spec_helper'
require 'nokogiri'

describe 'Request' do
  describe 'GET /' do
    it 'returns html view' do
      response = get '/', {}

      expect(response.status).to eq 302
      expect(response.headers['Location']).to eq 'http://example.org/index.html'
    end
  end

  describe 'GET /api/v1/menus' do
    it 'returns json' do

      response = get '/api/v1/menus', params = {calendar: 'prek-8-lunch', month: '1', day: '17'}

      expect(JSON.parse(response.body)).to eq JSON.parse('
{
  "content": {
    "menu": "\"Super Chef\"\nShepherd\'s Pie\nA Delicious Blend of Mashed\nPotatoes, Turkey, & Cheese\nLettuce\nOnion\nWarm Dinner Roll\nBroccoli Trees\nSalad Bar\nConfetti Corn Salad",
    "calendar": "prek-8-lunch",
    "month": "1",
    "day": "17"
  }
}
')

    end
  end
end
