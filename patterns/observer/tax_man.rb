#
# Represents tax man who monitors employee taxes.
class TaxMan
  #
  # Action done when employee's salary changed.
  def update( changed_employee )
    puts "Send #{changed_employee.name} a new tax bill!"
  end
end
