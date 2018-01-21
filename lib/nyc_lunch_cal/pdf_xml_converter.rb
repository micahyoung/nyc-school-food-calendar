require 'open3'
require 'nokogiri'

class NycLunchCal::PdfXmlConverter
  def parse(pdf_content)
    stdin, stdout = Open3.popen2('gs -sDEVICE=txtwrite -dTextFormat=1 -o - -')
    stdin.write(pdf_content)
    stdin.close
    stdout.readlines.select {|line| line[/</]}.join('')
  end
end