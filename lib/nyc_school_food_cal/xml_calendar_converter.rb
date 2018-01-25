require 'nokogiri'

class NycSchoolFoodCal::XmlCalendarConverter
  def parse(xml)
    doc = Nokogiri::XML(xml)
    filter = NycSchoolFoodCal::ContentFilter.new
    collector = NycSchoolFoodCal::ContentCollector.new

    doc.css('word').each do |span|
      next unless filter.ready?(span.text)

      content_location = NycSchoolFoodCal::ContentLocation.new(span.text, span.attr('xMin'), span.attr('yMin'), span.attr('xMax'), span.attr('yMax'))

      collector.add(content_location)
    end

    calendar_builder = NycSchoolFoodCal::CalendarBuilder.new(collector.day_locations, collector.content_locations)

    calendar_builder.data
  end
end