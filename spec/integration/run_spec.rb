require 'spec_helper'

describe 'Run' do
  let(:runner) { NycSchoolFoodCal::Runner.new(data_file_path: fixture_path('data')) }

  it 'should returns menu for date' do
    expect(runner.run(calendar: 'prek-8-breakfast', month: '1', day: '1')).to eq <<EOF.rstrip
Tasty Waffles
Served with Syrup
Turkey Canadian Bacon
Back to the Roots®
Organic Purple Corn Flakes
100% Fruit Juice
Seasonal Fresh Fruit
EOF
  end

  it 'parses and logs for all fixtures' do
    File.open(fixture_path('data/audit.log'), 'w') do |audit_log|
      Dir[fixture_path('data/**/*.pdf')].each do |file|
        audit_log.puts "=== #{Pathname.new(file).relative_path_from(Pathname.new(__FILE__))} ==="
        1.upto(32).each do |day|
          audit_log.puts sprintf('%02d ' + '-' * 30, day)

          calendar_name = File.basename(file, ".pdf")
          month = File.dirname(file).split('/').last
          result = runner.run(calendar: calendar_name, month: month, day: day.to_s)

          audit_log.puts result
          audit_log.puts sprintf('-' * 33, day)

          expect(result).to_not be_nil
        end
      end
    end
  end

end
