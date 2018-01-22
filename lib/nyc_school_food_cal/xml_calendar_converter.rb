require 'nokogiri'

class NycSchoolFoodCal::XmlCalendarConverter
  def parse(xml)
    doc = Nokogiri::XML(xml)
    day_collection = DayCollection.new
    content_locations = []

    doc.css('word').each do |span|
      content_location = ContentLocation.new(span.text, span.attr('xMin'), span.attr('yMin'), span.attr('xMax'), span.attr('yMax'))

      if day_collection.is_day?(content_location)
        day_collection.add(content_location)
      elsif day_collection.is_content?(content_location)
        content_locations.push(content_location)
      end
    end

    {}.tap do |data|
      content_locations.group_by {|l| day_collection.find_content_day(l) }.each do |day, day_content_locations|
        line_groups = day_content_locations.group_by {|content_location| content_location.bottom_y}.sort_by(&:first)

        data[day] = line_groups.map {|_, line_content_locations| line_content_locations.map(&:content).join(" ")}.join("\n")
      end
    end
  end

  class ContentLocation
    attr_reader :right_x, :bottom_y, :content

    def initialize(content, xMin, yMin, xMax, yMax)
      @content = content.strip
      @left_x, @top_y, @right_x, @bottom_y = xMin.to_i, yMin.to_i, xMax.to_i, yMax.to_i
    end
  end

  class DayCollection
    CELL_WIDTH = 144
    CELL_HEIGHT = 149

    def initialize()
      @day_locations = []
    end

    def add(location)
      if !@day_locations.any? {|l| l.content == location.content}
        @day_locations.push(location)
        true
      else
        false
      end
    end

    def find_content_day(content_location)
      matching_day_location = @day_locations.reverse.find {|day_location| day_contains_location?(day_location, content_location)}

      if matching_day_location
        matching_day_location.content
      end
    end

    def is_day?(content_location)
      !content_location.content[/^\d+$/].nil? && is_valid_y_for_day?(content_location)
    end

    def is_content?(content_location)
      content_location.content[/^\d+$/].nil?
    end

    private

    def is_valid_y_for_day?(content_location)
      if @day_locations.empty?
        content_location.content == '1'
      else
        content_location.bottom_y >= @day_locations.map(&:bottom_y).min
      end
    end

    def day_contains_location?(day_location, content_location)
      content_location.right_x > (day_location.right_x - CELL_WIDTH) &&
          content_location.right_x < (day_location.right_x) &&
          content_location.bottom_y > day_location.bottom_y &&
          content_location.bottom_y < (day_location.bottom_y + CELL_HEIGHT)
    end
  end
end
