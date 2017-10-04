module Concerns::Findable

  def find_by_name(name)
    all.detect do |thing|
      if thing.name == name
        return thing
      end
    end
  end



  def find_or_create_by_name(name)
    if self.find_by_name(name) == nil
      self.create(name)
    else
      self.find_by_name(name)
    end
  end

end
