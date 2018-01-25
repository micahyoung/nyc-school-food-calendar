require 'spec_helper'

module NycSchoolFoodCal
  describe 'PdfXmlConverter' do
    describe '#parse' do
      it 'returns XML' do
        pdf = File.read(fixture('input.pdf'))
        expected_xml = File.read(fixture('input.xml'))
        result = NycSchoolFoodCal::PdfXmlConverter.new.parse(pdf)
        expect(result).to eq(expected_xml)
      end
    end
  end
end