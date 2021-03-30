module Concerns
  module Findable

  def find_by_name(name)
    self.all.detect {|a| a.name == name}
  end

  def find_or_create_by_name(name)
    instance = self.find_by_name(name)
      if instance != nil
        instance
      else
        self.create(name)
      end
    end

end

end
