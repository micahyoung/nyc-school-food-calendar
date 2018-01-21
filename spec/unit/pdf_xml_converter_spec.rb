require 'spec_helper'

describe 'PdfXmlConverter' do
  describe '#parse' do
    it 'returns XML' do
      pdf = File.read(fixture('input.pdf'))
      expected_xml = File.read(fixture('input.xml'))
      result = NycLunchCal::PdfXmlConverter.new.parse(pdf)
      expect(result).to eq(expected_xml)
    end
  end
end