class ContentCollector
  attr_accessor :day_locations, :content_locations

  def initialize()
    @day_locations = []
    @content_locations = []
  end

  def add(location)
    if is_day?(location)
      if !@day_locations.any? {|l| l.content == location.content}
        if is_valid_y_for_day?(location)
          @day_locations.push(location)
        end
      end
    else
      @content_locations.push(location)
    end
  end

  def is_day?(content_location)
    !content_location.content[/^\d+$/].nil?
  end

  private

  def is_valid_y_for_day?(content_location)
    content_location.bottom_y >= (@day_locations.map(&:bottom_y).min || 0)
  end

end
