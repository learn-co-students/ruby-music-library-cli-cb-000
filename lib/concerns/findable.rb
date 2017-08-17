module Findable
  @@all = []
  
  def setup
    @@all  ||= []
  end
  
  def all
    @@all
  end
  
  def all_new
    all || all = []
  end
  
  def find_or_create_by_name(name)
     obj = find_by_name(name)
     obj ||= create(name)
  end
  
  def find_by_name(name)
    @all.detect{|obj| obj.name == name} unless @all.nil?
  end
  
  def create(name)
         new(name).tap {|obj| save(obj)}
  end
  
  def save(obj)
    @@all << obj
  end 
end 
