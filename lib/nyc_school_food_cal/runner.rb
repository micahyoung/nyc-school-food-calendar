require 'date'

class NycSchoolFoodCal::Runner
  def initialize
    @pdf_xml_converter = NycSchoolFoodCal::PdfXmlConverter.new
    @xml_calendar_parser = NycSchoolFoodCal::XmlCalendarConverter.new
  end

  def run(pdf_file, day)
    pdf_content = File.read(pdf_file)
    pdf_xml = @pdf_xml_converter.parse(pdf_content)
    calendar = @xml_calendar_parser.parse(pdf_xml)
    if calendar.has_key?(day)
      calendar.fetch(day)
    else
      "No menu found for this day"
    end
  end
end
