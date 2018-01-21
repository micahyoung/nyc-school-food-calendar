require 'open3'
require 'nokogiri'

class NycSchoolFoodCal::PdfXmlConverter
  def parse(pdf_content)
    stdin, stdout = Open3.popen2('gs -sDEVICE=txtwrite -dQUIET  -dTextFormat=1 -o - -')
    stdin.write(pdf_content)
    stdin.close
    stdout.readlines.join('')
  end
end