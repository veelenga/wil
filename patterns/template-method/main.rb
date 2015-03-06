require './report'
require './html_report'
require './plain_text_report'

title = 'Monthly report'
text = ['1. We did it',
        '2. We did that',
        '3. And then we did this']

puts '===> PlainTextReport <==='
report = PlainTextReport.new( title, text )
report.output_report


puts '======> HtmlReport <======'
report = HtmlReport.new( title, text )
report.output_report

