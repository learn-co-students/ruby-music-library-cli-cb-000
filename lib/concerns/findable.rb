module Concerns::Findable
  # finds an object instance in @@all by the name property of the object
  def find_by_name(name)
    self.all.detect { |object| object.name == name }
  end

  #  returns (does not recreate) an existing object with the provided name if one exists in @@all
  #  invokes .find_by_name instead of re-coding the same functionality
  # creates an object if an existing match is not found
  # invokes .create instead of re-coding the same functionality
  def find_or_create_by_name(name)
    find_by_name(name) ? find_by_name(name) : create(name)
  end
end
