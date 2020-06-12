module Concerns::Findable
  
  
  def find_by_name(name)
    self.all.detect do |song|
      return song if song.name == name
    end
  end
  
  def find_or_create_by_name(name)
    object = self.find_by_name(name)
    return object if object
    
    new_object = self.create(name)
    return new_object
  end
  
  
end