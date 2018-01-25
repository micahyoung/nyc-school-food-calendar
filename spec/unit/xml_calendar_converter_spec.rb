require 'spec_helper'

module NycSchoolFoodCal
  describe 'XmlCalendarConverter' do
    describe '#parse' do
      let(:xml) {File.read(fixture('input.xml'))}
      let(:data) {NycSchoolFoodCal::XmlCalendarConverter.new.parse(xml)}

      it 'should parse' do
        expect(data["1"]).to eq <<EOF.rstrip
Tasty Waffles
Served with Syrup
Turkey Canadian Bacon
Back to the Roots®
Organic Purple Corn Flakes
100% Fruit Juice
Seasonal Fresh Fruit
EOF

        expect(data["2"]).to eq <<EOF.rstrip
Whole Grain Bagel
with Cream Cheese & Jelly
Land O'Lakes®
Mozzarella Cheese Stick
Hot Oatmeal
Warm Peach Topper
100% Fruit Juice
Seasonal Fresh Fruit
EOF

        expect(data["3"]).to eq <<EOF.rstrip
Beef Sausage &
White Cheddar Sandwich
Organic Stonyfield® Yogurt
Served with
Craisins & Granola
100% Fruit Juice
Seasonal Fresh Fruit
EOF

        expect(data["4"]).to eq <<EOF.rstrip
Assorted Warm
NY Bagel Sticks
with Cream Cheese & Jelly
Upstate Farms®
Yogurt Choice
New York Apple Slices
EOF

        expect(data["5"]).to eq <<EOF.rstrip
Whole Grain Croissant
Served with Jelly
Turkey Sausage Crumble
& Cheese Wrap
Back to the Roots®
Organic Purple Corn Flakes
100% Fruit Juice
Seasonal Fresh Fruit
EOF

        expect(data["8"]).to eq <<EOF.rstrip
Buttermilk Pancakes
Served with Syrup
Turkey Canadian Bacon
Back to the Roots®
Organic Purple Corn Flakes
100% Fruit Juice
Seasonal Fresh Fruit
EOF

        expect(data["10"]).to eq <<EOF.rstrip
Cheese Omelet
with a Buttermilk Biscuit
Organic Stonyfield® Yogurt
Honey Roasted
Sunflower Seeds
100% Fruit Juice
Seasonal Fresh Fruit
EOF

        expect(data["11"]).to eq <<EOF.rstrip
Assorted Warm
NY Bagel Sticks
with Cream Cheese & Jelly
Upstate Farms®
Yogurt Choice
New York Apple Slices
EOF

        expect(data["17"]).to eq <<EOF.rstrip
Canadian Bacon,
Egg & Cheese
on an English Muffin
Organic Stonyfield® Yogurt
Served with
Craisins & Granola
100% Fruit Juice
Seasonal Fresh Fruit
EOF

        expect(data["25"]).to eq <<EOF.rstrip
Assorted Warm
NY Bagel Sticks
with Cream Cheese & Jelly
Upstate Farms®
Yogurt Choice
New York Apple Slices
EOF


        expect(data["30"]).to eq <<EOF.rstrip
Whole Grain Bagel
with Cream Cheese & Jelly
Land O'Lakes®
Colby Cheese Stick
Hot Oatmeal
Warm Peach Topper
100% Fruit Juice
Seasonal Fresh Fruit
EOF

        expect(data["31"]).to eq <<EOF.rstrip
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
end