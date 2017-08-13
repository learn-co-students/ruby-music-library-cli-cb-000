module Concerns
  module Findable

    def find_by_name(name)
      self.all.detect { |a| a.name == name }
    end

    def find_or_create_by_name(name)
      found_or_created = self.find_by_name(name)
      if found_or_created.nil?
        found_or_created = self.create(name)
      end
      found_or_created
    end

  end

end
