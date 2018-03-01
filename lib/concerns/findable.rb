module Concerns::Findable

  def find_by_name(name)
    all.find{|song| song.name == name}
  end

  def find_or_create_by_name(name)
    !!self.find_by_name(name) ? self.find_by_name(name) : self.create(name)
  end

  def sorted
    all.sort{|s1,s2| s1.name <=> s2.name}
  end

end
