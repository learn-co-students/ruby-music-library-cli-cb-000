module Concerns::Findable
    def find_by_name(name)
      self.all.detect {|song| song.name == name}
    end

    def self.create(name)
      song = self.new(name)
      song.save
      song
    end

    def find_or_create_by_name(name)
      self.find_by_name(name)? self.find_by_name(name) : self.create(name)
    end
end
