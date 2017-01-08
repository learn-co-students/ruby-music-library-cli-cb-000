module Concerns
  module Findable
    def find_by_name(name)
      self.all.detect{|i| i.name==name}
    end

    def find_or_create_by_name(name)
      if self.find_by_name(name) == nil
        a = self.create(name)
      end
      self.find_by_name(name)
    end
  end
end
