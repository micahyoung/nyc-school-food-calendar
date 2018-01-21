require 'spec_helper'

describe 'XmlCalendarConverter' do
  describe '#parse' do
    let(:xml) { File.read(fixture('input.xml')) }
    let(:data) { NycLunchCal::XmlCalendarConverter.new.parse(xml) }

    it 'should parse' do
      expect(data["1"]).to eq <<EOF
Tasty Waffles
Served with Syrup
Turkey Canadian Bacon
Back to the Roots®
Organic Purple Corn Flakes
100% Fruit Juice
Seasonal Fresh Fruit
EOF

      expect(data["10"]).to eq <<EOF
Cheese Omelet
with a Buttermilk Biscuit
Organic Stonyfield® Yogurt
Honey Roasted
Sunflower Seeds
100% Fruit Juice
Seasonal Fresh Fruit
EOF

      expect(data["11"]).to eq <<EOF
Assorted Warm
NY Bagel Sticks
with Cream Cheese & Jelly
Upstate Farms®
Yogurt Choice
New York Apple Slices
EOF

      expect(data["31"]).to eq <<EOF
Cheese Omelet
with a Buttermilk Biscuit
Organic Stonyfield® Yogurt
Honey Roasted
Sunflower Seeds
100% Fruit Juice
Seasonal Fresh Fruit
EOF

    end
  end
end