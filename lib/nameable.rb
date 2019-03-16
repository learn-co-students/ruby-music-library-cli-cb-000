module Nameable
    module ClassMethods
        def create(name)
        
            #tap automatically returns the object itself
            #so even though this is a constructor, we 
            #do not have to explicitly return "self"
            self.new(name).tap do |o|
                o.name = name
                o.save
            end
        end
    end #ClassMethods
    module InstanceMethods
    end #InstanceMethods
end #Nameable