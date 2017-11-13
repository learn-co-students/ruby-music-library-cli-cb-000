module Concerns::Findable

  def find_by_name(name)
    self.all.find { |entry| entry.name == name }
  end

  def find_or_create_by_name(name)
    entry = self.find_by_name(name)
    !!entry ? entry : self.create(name)
  end

end
