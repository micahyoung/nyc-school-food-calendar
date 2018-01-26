require 'spec_helper'

module NycSchoolFoodCal
  describe 'PdfXmlConverter' do
    describe '#parse' do
      let(:converter) {NycSchoolFoodCal::PdfXmlConverter.new}

      context 'when parsing succeeds' do
        it 'returns XML' do
          pdf = File.read(fixture_path('input.pdf'))

          result = converter.parse(pdf)

          expect(result).to eq File.read(fixture_path('input.xml'))
        end
      end

      context 'when parsing fails' do
        it 'raises exception' do
          expect {
            converter.parse(nil)
          }.to raise_error(NycSchoolFoodCal::PdfXmlConverter::ParseError)
        end
      end
    end
  end
end