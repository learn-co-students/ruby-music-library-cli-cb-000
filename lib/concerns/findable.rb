module Concerns::Findable
  def find_by_name(name)
    self.all.detect { |o| o.name == name }
  end

  def find_or_create_by_name(name)
    obj = self.find_by_name(name)
    if obj.nil?
      self.create(name)
    else
      obj
    end
  end
end
