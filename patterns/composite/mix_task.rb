require './task'

class MixTask < Task
  def initialize
    super('Mix task')
  end

  def time_required
    3.0
  end
end
