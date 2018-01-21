require 'date'

class NycLunchCal::Runner
  def initialize
    @pdf_xml_converter = NycLunchCal::PdfXmlConverter.new
    @xml_calendar_parser = NycLunchCal::XmlCalendarConverter.new
  end

  def run(pdf_file, day)
    pdf_content = File.read(pdf_file)
    pdf_xml = @pdf_xml_converter.parse(pdf_content)
    calendar = @xml_calendar_parser.parse(pdf_xml)
    calendar.fetch(day) if calendar.has_key?(day)
  end
end
