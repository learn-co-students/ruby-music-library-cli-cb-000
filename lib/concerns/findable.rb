module Concerns::Findable
  def find_by_name(song)
    self.all.detect {|i| i.name == song}
  end

  def find_or_create_by_name(song)
    self.find_by_name(song) == nil ? self.create(song) : self.find_by_name(song)
  end

end
