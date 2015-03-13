
class Reporter
  attr_reader :text, :title
  attr_accessor :formatter

  def initialize( formatter )
    @title = 'Monthly report'
    @text = ['This', 'is', 'my', 'monthly', 'report']
    @formatter = formatter
  end

  def output_report
    @formatter.output_report self
  end
end
