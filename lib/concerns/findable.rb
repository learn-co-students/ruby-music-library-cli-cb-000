module Concerns::Findable
    ## methods
    def find_by_name(name)
      # puts "Looking for #{name}. Result: #{self.all.detect {|s| s.name == name}}"
      # This doesn't work!  every artist object is the same
      self.all.detect {|s| s.name == name}

    end

    def find_or_create_by_name(name)
      # binding.pry
      if self.find_by_name(name) == nil
        x = self.create(name)
      else
        x = self.find_by_name(name)
        # puts "I found #{self} value is #{x}"
        # binding.pry
      end
      x
    end

  end
