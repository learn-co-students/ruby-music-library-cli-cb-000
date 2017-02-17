

module NamedListable
	module ClassMethods

		def destroy_all
			all.clear
		end

		def all
			@all = [] if @all==nil
			@all
		end

		def create(name)
			self.new(name).tap {|song| song.save}
		end

	end
	module InstanceMethods
		attr_accessor :name
		def initialize(name)
			@name = name
		end

		def save
			self.class.all<<self
		end
	end
end
