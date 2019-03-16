module Persistable
    module ClassMethods
        #example of defining an instance variable and "metaprogramming" - which is
        #just programming that creates code as in creating a variable below.
        
        #in the class, when the interpreter reads "extend Persistable::ClassMethods"
        #the next line of code to be executed is the first line of code in this file
        #so the argument base, that is always passed to this method, is always
        #the class that is extended -- so in this case it may be "Song"
        #the class that is extended by this module is the argument that is
        #passed in as "base"

        #so the line puts "#{base} has been extended by #{self}"
        #will print "Song has been extended by Persistable::ClassMethods"
        #def self.extended(base) #Hook
            #puts "#{base} has been extended by #{self}"
            #Song has been extended by Persistable::ClassMethods
            #base.class_variable_set(:@@all, [])
        #end

        def destroy_all
            self.all.clear
        end
    
        def printAll
            self.all.each{ |x| puts("Name:  #{x.name}\n")}
        end

        def reset_all
            self.all.clear
        end

        def count
            self.all.size
        end

    end #ClassMethods

    module InstanceMethods
        def save
            self.class.all << self
        end
    end #InstanceMethods
end #Persistable

