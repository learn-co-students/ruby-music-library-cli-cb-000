module Concerns
  module Findable
    def find_by_name(title)
      self.all.detect {|thing| thing.name == title}
    end

    def find_or_create_by_name(name)
      if self.find_by_name(name) == nil
        self.create(name)
      else
        self.find_by_name(name)
      end
    end

    def create(name)
      self.new(name).tap do |f|
        f.save
      end
    end

  end

end
