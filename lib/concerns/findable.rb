module Concerns::Findable

  def find_by_name(name)
    all.detect{|i|i.name == name}
  end

  def find_or_create_by_name(name)
    new_object = all.detect{|i|i.name == name}
    new_object = create(name) if !new_object
    new_object
  end

end