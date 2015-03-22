require './composite_task'
require './mix_task'
require './add_dry_ingredients_task'

class MakeBatterTask < CompositeTask

  def initialize
    super('Make batter')
    self << MixTask.new
    self << AddDryIngredientsTask.new
  end
end
