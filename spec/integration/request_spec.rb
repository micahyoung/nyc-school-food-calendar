require 'spec_helper'
require 'request_spec_helper'

describe 'Request' do
  it do
    response = get '/', params = {calendar: 'prek-8-lunch', month: '1', day: '17'}

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
