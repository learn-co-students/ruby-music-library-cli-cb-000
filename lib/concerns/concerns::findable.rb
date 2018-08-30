module Concerns::Findable
  def find_by_name(name)
    self.all.find{|obj| obj.name == name}
  end

  def create_by_name(name)
    create(name)
  end

  def create(name)
    new_obj = self.new(name)
    new_obj.save
    new_obj
  end

  def find_or_create_by_name(name)
    found = find_by_name(name)
    if found != nil
    then
      return found
    else
      create_by_name(name)
    end
  end
end
