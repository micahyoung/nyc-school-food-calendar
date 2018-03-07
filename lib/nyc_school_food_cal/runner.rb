require 'date'

class NycSchoolFoodCal::Runner
  def initialize(data_file_path:)
    @pdf_xml_converter = NycSchoolFoodCal::PdfXmlConverter.new
    @xml_calendar_parser = NycSchoolFoodCal::XmlCalendarConverter.new
    @file_finder = NycSchoolFoodCal::FileFinder.new(data_file_path: data_file_path)
  end

  def menu(calendar:, month:, day:)
    begin
      calendar_pdf = @file_finder.get_content(calendar: calendar, month: month)
      pdf_xml = @pdf_xml_converter.parse(calendar_pdf)
      calendar = @xml_calendar_parser.parse(pdf_xml)
      calendar.fetch(day)
    rescue RuntimeError, KeyError => e
      NycSchoolFoodCal::Logger.warn(e)

      "No menu found for this day"
    end
  end

  def calendars
      calendar_names = @file_finder.get_calendar_names
  end
end
