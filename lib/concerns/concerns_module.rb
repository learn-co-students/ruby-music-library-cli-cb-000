module Concerns

  module AllInstanceMethods
    #we want to save all instances to @@all upon creation
		def initialize
			#we so self.class = Song.all method = return @@all << self
			self.class.all << self
		end

		#instances should be able to push themselves unto @@all
		def save
			self.class.all << self
		end
  end

  module AllClassMethods
    #returns @@all refrenced by self.all
		def all
			self.all
		end

		#calls Song.all method then clears the []
		def destroy_all
			self.all.clear
		end

  end

  module Findable
    #searches @@all for <>.name to match
		def find_by_name(name)
			self.all.detect{|o| o.name == name}
		end

		def find_or_create_by_name(name)
			self.find_by_name(name) ? self.find_by_name(name) : self.create(name)
		end
  end

end
