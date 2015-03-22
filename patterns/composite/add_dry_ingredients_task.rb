require './task'

class AddDryIngredientsTask < Task
  def initialize
    super('Add dry ingredients')
  end

  def time_required
    1.0
  end
end
