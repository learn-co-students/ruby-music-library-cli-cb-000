module Concerns
  module Findable
    def find_by_name(name)
      self.all.find(&:name)
    end

    def find_or_create_by_name(name)
      return if name.nil?
      existing = find_by_name(name)
      return if existing.nil?
      if name != existing.name
        return self.create(name)
      else
        return existing
      end
    end
  end
end