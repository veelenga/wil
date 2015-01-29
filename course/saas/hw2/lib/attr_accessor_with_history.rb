class Class
  def attr_accessor_with_history(attr_name)
    attr_name = attr_name.to_s # make sure it's a string
    attr_reader attr_name # create the attribute's getter
    attr_reader attr_name + "_history" # create bar_history getter
    class_eval %Q{
    	def #{attr_name}=(value)
		if @#{attr_name}_history == nil
			@#{attr_name}_history = Array.new
		end
		@#{attr_name}_history << @#{attr_name}

		@#{attr_name} = value
	end
    }
  end
end

=begin
class Foo
	attr_accessor_with_history :bar
end

f = Foo.new
f.bar = 3
p f.bar
f.bar = :wowzo
f.bar = 'boo!'

p f.bar_history
=end
