require 'spec_helper'

describe 'ContentCollactor' do
  let(:collector) {ContentCollector.new}

  describe '#add' do
    context 'when location is a day' do
      context 'and collector is empty' do
        context 'and new day is 1' do
          it 'adds to days' do
            location = ContentLocation.new('1', 1, 1, 1, 1)
            collector.add(location)
            expect(collector.day_locations).to eq([location])
          end
        end
      end

      context 'and collector contains an existing day' do
        let(:existing_location) {ContentLocation.new('1', 1, 2, 3, 4)}

        before do
          collector.add(existing_location)
        end

        context 'and a unique day is added' do
          context 'and the day is aligned with the existing day' do
            it 'adds both' do
              location = ContentLocation.new('2', 1, 1, 1, 4)
              collector.add(location)
              expect(collector.day_locations).to eq([existing_location, location])
            end
          end

          context 'and the day is above with the existing day' do
            it 'adds both' do
              location = ContentLocation.new('2', 1, 1, 1, 1)
              collector.add(location)
              expect(collector.day_locations).to eq([existing_location])
            end
          end
        end

        context 'and a duplicate day is added' do
          it 'does not add' do
            location = ContentLocation.new('1', 1, 2, 3, 4)
            collector.add(location)
            expect(collector.day_locations).to eq([existing_location])
          end
        end
      end
    end
    context 'when location is not a day' do
      it 'is added to content' do
        location = ContentLocation.new('FOO', 1, 1, 1, 1)
        collector.add(location)
        expect(collector.content_locations).to eq([location])
      end
    end
  end
end