module Concerns
  module Findable
    def find_or_new_by_name(name)
      self.find_by_name(name) || self.new(name)
    end

    def find_or_create_by_name(name)
      self.find_by_name(name) || self.create(name)
    end

    def find_by_name(name)
      self.all[name] if name = self.all.find_index { |s| s.name == name }
    end

  end
end
