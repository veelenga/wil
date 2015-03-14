#
# Represents payroll department of pay changes.
class Payroll
  #
  # Action on employee salary change.
  #
  # +changed_employee+:: employee whose salary was changed.
  def update( changed_employee )
    puts "Cut a new check for #{changed_employee.name}!"
    puts "His salary is now #{changed_employee.salary}!"
  end
end
