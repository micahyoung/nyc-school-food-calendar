class NycSchoolFoodCal::ContentFilter
  attr_reader :is_header_found

  def initialize
    @is_header_found = false
  end

  def ready?(term)
    if term =~ /Monday/i
      @is_header_found = true
    end

    return is_header_found
  end
end