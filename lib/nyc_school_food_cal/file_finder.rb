class NycSchoolFoodCal::FileFinder
  def initialize(data_file_path:)
    @data_file_path = data_file_path
  end

  def get_content(calendar:, month:)
    target_file = File.join(@data_file_path, month, "#{calendar}.pdf")

    puts @data_file_path

    file = available_files.find do |file|
      file == target_file
    end

    raise FileNotFoundError if file.nil?

    File.read(file)
  end

  private

  def available_files
    Dir[File.join(@data_file_path, '*', '*.pdf')]
  end

  class FileNotFoundError < RuntimeError; end
end