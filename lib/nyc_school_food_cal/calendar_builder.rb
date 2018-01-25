class CalendarBuilder
  CELL_WIDTH = 140
  CELL_HEIGHT = 149

  def initialize(day_locations=nil, content_locations=nil)
    @day_locations = day_locations
    @content_locations = content_locations
  end

  def data
    {}.tap do |data|
      @content_locations.group_by {|l| find_content_day(l)}.each do |day, day_content_locations|
        next if day.nil?

        line_groups = day_content_locations
                          .sort_by {|content_location| content_location.right_x}
                          .group_by {|content_location| content_location.bottom_y}.sort_by(&:first)

        data[day] = line_groups.map {|_, line_content_locations| line_content_locations.map(&:content).join(" ")}.join("\n")
      end
    end
  end

  private

  def find_content_day(content_location)
    matching_day_location = @day_locations.reverse.find {|day_location| day_contains_location?(day_location, content_location)}

    if matching_day_location
      matching_day_location.content
    end
  end


  def day_contains_location?(day_location, content_location)
    content_location.right_x > (day_location.right_x - CELL_WIDTH) &&
        content_location.right_x < (day_location.right_x) &&
        content_location.bottom_y > day_location.bottom_y &&
        content_location.bottom_y < (day_location.bottom_y + CELL_HEIGHT)
  end
end
