
require './subject.rb'
require './employee.rb'
require './payroll.rb'
require './tax_man.rb'

tax_man = TaxMan.new
payroll = Payroll.new

employee = Employee.new( 'name', 'title', 30000)
employee.add_observer( tax_man )
employee.add_observer( payroll )

employee.salary = 30001
