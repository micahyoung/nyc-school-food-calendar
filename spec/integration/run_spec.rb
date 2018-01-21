require 'spec_helper'

describe 'Run' do
  it 'should returns menu for date' do
    expect(NycLunchCal::Runner.new.run(fixture('input.pdf'), '1')).to eq <<EOF
Tasty Waffles
Served with Syrup
Turkey Canadian Bacon
Back to the Roots®
Organic Purple Corn Flakes
100% Fruit Juice
Seasonal Fresh Fruit
EOF
  end
end
