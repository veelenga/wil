require './report'

# This is a plain text report. Template of report
# located in base class.
# You can print your report using #print_report
# method.
#
#   report = PlainTextReport.new(title, text)
#   report.output_report
class PlainTextReport < Report

  def initialize( title, text )
    super(title, text)
  end

  def header
    @title
  end

  def body
    @text.join '\n'
  end

  def footer
    'Generated in 2015 by PlainTextReport generator'
  end
end
