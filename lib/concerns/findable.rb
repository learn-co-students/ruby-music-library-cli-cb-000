module Concerns::Findable
  def find_by_name(name)
    self.all.detect{|x| x.name == name}
  end

  def find_or_create_by_name(name)
    self.find_by_name(name) || self.create(name)
  end

  # The tests keep me from doing it this way:
  # module ClassMethods
  #   def find_by_name(name)
  #     self.all.detect{|x| x.name == name}
  #   end
  #
  #   def find_or_create_by_name(name)
  #     self.find_by_name(name) || self.create(name)
  #   end
  # end
end
