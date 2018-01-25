require 'spec_helper'

describe 'ContentFilter' do
  let(:filter) {NycSchoolFoodCal::ContentFilter.new}

  describe '#ready?' do
    context 'when weekday header is found is a day' do
      it 'returns true' do
        expect(filter.ready?('foo')).to eq(false)
        expect(filter.ready?('Monday')).to eq(true)
        expect(filter.ready?('foo')).to eq(true)
      end
    end
  end
end