module Concerns::Findable
  def find_by_name(name)
    all.find{ |o| o.name == name}
  end

  def find_or_create_by_name(name)
    o=find_by_name(name)
    if o == nil
      o=create(name)
      return o
    else
      return o
    end
  end
end
