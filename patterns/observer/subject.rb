#
# Represents +Subject+ in +observer+ pattern by GoF.
# Mixin this module to be able to notify observers.
module Subject
  #
  # Adds new observer to observer list.
  #
  # +observer+:: the object that will be notified of changes.
  def add_observer( observer )
    @observers = [] unless defined? @observers
    @observers << observer
  end

  #
  # Removes observer from observer list.
  #
  # +observer+:: an observer from observer list.
  def delete_observer( observer )
    @observers.delete( observer ) if defined? @observers
  end

  #
  # Notifies observers from observer list.
  def notify_observers
    if defined? @observers
      @observers.each do |observer|
        observer.update( self )
      end
    end
  end
end
