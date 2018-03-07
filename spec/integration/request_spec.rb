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

  describe 'GET /api/v1/calendars' do
    it 'returns json' do

      response = get '/api/v1/calendars'

      expect(JSON.parse(response.body)).to eq JSON.parse('
{
  "content": {
    "calendars": [
      "alternative-afterschool",
      "classroom-breakfast",
      "cold-afterschool",
      "cold-lunch-saturday",
      "cold-morning-snack-saturday",
      "early-childhood-breakfast",
      "early-childhood-lunch",
      "early-childhood-snack-afterschool",
      "express-breakfast",
      "food-court",
      "hot-afterschool",
      "hot-lunch-saturday",
      "hot-morning-snack-saturday",
      "hs-alternative-lunch",
      "hs-breakfast",
      "hs-express-cold-lunch",
      "hs-express-hot-lunch",
      "hs-lunch",
      "hs-special-needs-lunch",
      "ms-lunch",
      "prek-8-alternative-lunch",
      "prek-8-breakfast",
      "prek-8-express-cold-lunch",
      "prek-8-express-hot-lunch",
      "prek-8-lunch",
      "prek-8-special-needs-lunch",
      "prek-8-vegetarian-lunch",
      "puree-breakfast",
      "puree-lunch",
      "snack-afterschool",
      "special-needs-breakfast",
      "vegetarian-breakfast"
    ]
  }
}
')

    end
  end
end
