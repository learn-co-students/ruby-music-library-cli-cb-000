module Basics
  module ClassMethods

    def destroy_all
      self.all.clear
    end

    def create(name)
      a = self.new(name)
      a.save
      a
    end



  end

  module InstanceMethods

    def initialize (name)
      self.name = name
    end

    def save
      self.class.all << self
    end

  end

end
