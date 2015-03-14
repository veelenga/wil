#
# Represents employee.
class Employee
  include Subject

  attr_reader :name, :address, :salary

  def initialize( name, title, salary )
    @name = name
    @title = title
    @salary = salary
  end

  # Sets employee's salary and notify all observers about change.
  #
  # +new_salary+:: new employee's salary.
  def salary=( new_salary)
    if @salary != new_salary
      @salary = new_salary
      notify_observers
    end
  end
end
