require 'pry'
module Concerns::Findable
  def find_or_create_by_name(name)
     obj = find_by_name(name)
     obj ||= create(name)
  end
  
  def find_by_name(name)
    all.detect{|obj| obj.name == name} unless all.nil?
  end
  
  def create(name)
         new(name)
  end
  
  def find_all_of_type(class_name)
    all.find_all { |obj| obj.instance_of?class_name }
  end
end
