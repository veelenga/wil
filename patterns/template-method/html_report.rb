require './report'

# This is html report. Template of report located in base class.
# You can print your report using #output_report method.
#
#   reporter = HtmlReporter.new( title, text )
#   reporter.output_report
class HtmlReport < Report

  def initialize( title, text )
    super(title, text)
  end

  def header
    "<header>#{@title}</header>"
  end

  def body
    text = @text.map do |line|
      line + '</br>'
    end.join

    "<body>#{text}</body>"
  end

  def footer
    'All rights reserved. (c) 2015'
  end
end
