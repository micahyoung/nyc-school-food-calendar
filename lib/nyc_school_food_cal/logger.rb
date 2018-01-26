require 'logger'

class NycSchoolFoodCal::Logger
  class << self
    def warn(e)
      logger.warn(e)
    end

    private

    def logger
      ::Logger.new(STDOUT)
    end
  end
end