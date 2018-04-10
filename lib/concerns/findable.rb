module Concerns::Findable
#  module InstanceMethods

#  end

#  module ClassMethods

#  end

    def find_by_name(name)
      self.all.detect { |o| o.name == name  }
    end

    def find_or_create_by_name(name)
#binding.pry
      self.find_by_name(name) || self.create(name)
#      find_by_name(name) || create(name)
#binding.pry
    end

#    def create_by_name(name)
#      self.new.tap do |o|
#        o.name = name
#      end
#    end

end
