require './mix_task'
require './add_dry_ingredients_task'
require './mix_task'
require './make_batter_task'

make_batter = MakeBatterTask.new
puts make_batter.time_required

composite = CompositeTask.new('my composite task')
composite << AddDryIngredientsTask.new
composite << MixTask.new
puts composite.time_required
