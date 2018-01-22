require 'spec_helper'

describe 'Run' do
  it 'should returns menu for date' do
    expect(NycSchoolFoodCal::Runner.new.run(fixture('input.pdf'), '1')).to eq <<EOF.rstrip
Tasty Waffles
Served with Syrup
Turkey Canadian Bacon
Back to the Roots®
Organic Purple Corn Flakes
100% Fruit Juice
Seasonal Fresh Fruit
EOF
  end

  it 'never crashes' do
    File.open(fixture('all/audit.log'), 'w') do |audit_log|
      Dir[fixture('all/*.pdf')].each do |file|
        audit_log.puts "=== #{Pathname.new(file).relative_path_from(Pathname.new(__FILE__))} ==="
        1.upto(32).each do |day|
          audit_log.puts sprintf('%02d ' + '-' * 30, day)

          result = NycSchoolFoodCal::Runner.new.run(file, day.to_s)

          audit_log.puts result
          audit_log.puts sprintf('-' * 33, day)

          expect(result).to_not be_nil
        end
      end
    end
  end

end
