module Concerns::Findable

  def find_by_name(name)
    self.all.find { |x| x.name == name}
  end

  def create(name)
   new_entry = self.new(name)
   new_entry.save
   new_entry
  end

  def find_or_create_by_name(name)
    self.find_by_name(name) || self.create(name)
  end

end
