module Concerns::Findable
  def find_by_name(name)
     self.all.detect{|song| song.name == name}
   end
   def find_or_create_by_name(name)
     element = find_by_name(name)
     if  element == nil
       element = self.create(name)
     end
     element
  end
end
