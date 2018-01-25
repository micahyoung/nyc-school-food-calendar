require 'spec_helper'

describe 'CalendarBuilder' do
  describe '#data' do
    # valid values
    let(:day_right_x) {1000}
    let(:day_bottom_y) {1000}
    let(:content_right_x) {990}
    let(:content_bottom_y) {1100}

    describe 'boundaries' do
      let(:builder) {CalendarBuilder.new([day_location], [content_location])}
      let(:day_location) {ContentLocation.new('1', (day_right_x - 10), (day_bottom_y + 10), day_right_x, day_bottom_y)}
      let(:content_location) {ContentLocation.new('foo', (content_right_x - 10), (content_bottom_y + 10), content_right_x, content_bottom_y)}
      context 'when content is within day boundaries' do
        context 'b/c below and left' do
          it 'adds to days' do
            expect(builder.data).to eq({'1' => 'foo'})
          end
        end

      end

      context 'when content is outside day boundaries' do
        context 'b/c too far right' do
          let(:content_right_x) {1001}

          it 'does not get added' do
            expect(builder.data).to eq({})
          end
        end

        context 'b/c too far left' do
          let(:content_right_x) {850}

          it 'does not get added' do
            expect(builder.data).to eq({})
          end
        end

        context 'b/c too far above' do
          let(:content_bottom_y) {999}

          it 'does not get added' do
            expect(builder.data).to eq({})
          end
        end

        context 'b/c too far below' do
          let(:content_bottom_y) {1200}

          it 'does not get added' do
            expect(builder.data).to eq({})
          end
        end
      end
    end

    describe 'content merging' do
      context 'with vertically aligned contents' do
        let(:builder) {CalendarBuilder.new(day_locations, content_locations)}
        let(:day_locations) {[ContentLocation.new('1', 1000, 1000, 1000, 1000)]}
        let(:content_locations) {[
            ContentLocation.new('foo', 1000, 1000, 990, 1100),
            ContentLocation.new('bar', 1000, 1000, 980, 1100),
        ]}

        it 'merges  left-right order based on bottom_x' do
          expect(builder.data).to eq({'1' => 'bar foo'})
        end
      end

      context 'with vertically unaligned contents' do
        let(:builder) {CalendarBuilder.new(day_locations, content_locations)}
        let(:day_locations) {[ContentLocation.new('1', 1000, 1000, 1000, 1000)]}
        let(:content_locations) {[
            ContentLocation.new('baz', 1000, 1000, 990, 1110),
            ContentLocation.new('foo', 1000, 1000, 990, 1100),
            ContentLocation.new('bar', 1000, 1000, 980, 1100),
        ]}

        it 'joins lines with newlines' do
          expect(builder.data).to eq({'1' => "bar foo\nbaz"})
        end
      end
    end
  end
end