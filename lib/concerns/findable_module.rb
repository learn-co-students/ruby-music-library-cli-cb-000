module Concerns

  module Findable



    def find_or_create_by_name(name)
      if self.find_by_name(name)
        self.find_by_name(name)
      else
        name = self.new(name)
        name.save
        name
      end

    end

    def find_by_name(name)
     self.find(name)
    end

    def find(name)
      self.all.find {|object| object.name == name}
    end


  
 end


end
