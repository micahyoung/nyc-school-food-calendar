require 'nokogiri'

class NycLunchCal::XmlCalendarConverter
  CELL_WIDTH = 144
  CELL_HEIGHT = 166

  def parse(xml)
    doc = Nokogiri::XML(xml)
    date_location = []
    data = {}
    doc.css('span').each do |span|
      content = span.css('char').map { |e| e['c'] }.join('')
      bbox = span.attr('bbox')
      content_location = ContentLocation.new(content, bbox)

      if content_location.is_day?
        date_location.push(content_location)
      else
        matching_content_location = date_location.reverse.find do |day_content_location|
          content_location.right_x > (day_content_location.right_x - CELL_WIDTH) &&
          content_location.right_x < (day_content_location.right_x) &&
              content_location.bottom_y > day_content_location.bottom_y &&
              content_location.bottom_y < (day_content_location.bottom_y + CELL_HEIGHT)
        end

        if matching_content_location
          data[matching_content_location.day] ||= ''
          data[matching_content_location.day] += content_location.content + "\n"
        end
      end
    end

    data
  end

  class ContentLocation
    attr_reader :right_x, :bottom_y, :content

    def initialize(content, bbox)
      @content = content.strip
      @left_x, @top_y, @right_x, @bottom_y = bbox.split(/ /).map(&:to_i)
    end

    def is_day?
      !day.nil?
    end

    def day
      @content[/\d+$/]
    end
  end
end
