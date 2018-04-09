module Concerns
  module Findable

    def find_by_name(name)
    self.all.each do |song|
      return song if song.name == name
    end
    return nil
  end

  def find_or_create_by_name(name)
    song = self.find_by_name(name)
    return song if song != nil
    return self.create(name) if song == nil
  end

  end
end
