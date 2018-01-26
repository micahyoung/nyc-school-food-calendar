require 'spec_helper'

describe 'FileFinder' do
  describe '#get_content' do
    let(:finder) do
      NycSchoolFoodCal::FileFinder.new(data_file_path: fixture_path('data'))
    end

    context 'when file exists' do
      it 'returns content' do
        result = finder.get_content(month: '1', calendar: 'prek-8-lunch')

        expect(result).to eq File.read(fixture_path('data/1/prek-8-lunch.pdf'))
      end
    end

    context 'when does not exist' do
      it 'raises exception' do
        expect {
          finder.get_content(month: '13', calendar: 'foo')
        }.to raise_error(NycSchoolFoodCal::FileFinder::FileNotFoundError)
      end
    end
  end
end