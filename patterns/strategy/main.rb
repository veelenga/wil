require './reporter'
require './html_formatter'
require './plain_text_formatter'

html_formatter = HTMLFormatter.new
plain_text_formatter = PlainTextFormatter.new

puts '=====> HTML report <===== '
r = Reporter.new( html_formatter )
r.output_report

puts '=====> TEXT report <===== '
r.formatter = plain_text_formatter
r.output_report
