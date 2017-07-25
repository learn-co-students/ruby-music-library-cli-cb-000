
module Concerns
  module Findable
    def find_by_name(name)
      self.all.detect {|i| i.name == name}
    end

    def find_or_create_by_name(name)
      match = find_by_name(name)
      (match)? match : self.create(name)
    end
  end
end
