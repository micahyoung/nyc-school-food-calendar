require 'open3'
require 'nokogiri'

class NycSchoolFoodCal::PdfXmlConverter
  def parse(pdf_content)
    stdin, stdout, stderr = Open3.popen3('pdftotext -bbox - -')
    stdin.write(pdf_content)
    stdin.close

    result = stdout.readlines.join

    raise ParseError.new(stderr) unless result.include?('DOCTYPE')

    result
  end

  class ParseError < RuntimeError; end
end
