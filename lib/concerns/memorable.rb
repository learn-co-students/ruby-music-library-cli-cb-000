module Memorable
  module ClassMethods
    def create(name)
      obj = self.new(name)
      self.all << obj
      obj
    end

    def destroy_all
      self.all.clear
    end
  end

  module InstanceMethods
    def save
      self.class.all << self
    end
  end
end
