module Concerns
  module Findable

  def find_by_name(name)
    return_variable = nil
    self.all.each do |song|
      if song.name == name
        return_variable = song
      end
    end
    return_variable
  end

  def find_or_create_by_name(name)
    info = self.find_by_name(name)
    return_variable = nil
    if info == nil
      return_variable = self.create(name)
    else
      return_variable = info
    end
    return_variable
  end

end
end
