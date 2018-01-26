require 'spec_helper'
require 'request_spec_helper'

describe 'Request' do
  it do
    response = get '/', params={calendar: 'prek-8-lunch', month: '1', day: '17'}

    expect(response.body).to eq <<EOF.rstrip
"Super Chef"
Shepherd's Pie
A Delicious Blend of Mashed
Potatoes, Turkey, & Cheese
Lettuce
Onion
Warm Dinner Roll
Broccoli Trees
Salad Bar
Confetti Corn Salad
EOF
  end
end
