module Concerns
  module Findable
    def find_by_name(name)
      self.all.find {|obj| obj.name == name}
    end

    def find_or_create_by_name(name)
      temp = find_by_name(name)
      temp ||= create(name)
    end
  end
end
