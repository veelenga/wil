require './task'

class CompositeTask < Task
  def initialize(name)
    super(name)
    @sub_tasks = []
  end

  def <<(sub_task)
    @sub_tasks << sub_task
  end

  def [](index)
    @sub_tasks[index]
  end

  def []=(index, sub_task)
    @sub_tasks[index] = sub_task
  end

  def time_required
    time = 0.0
    @sub_tasks.each { |task| time += task.time_required }
    time
  end
end
