module Memorable
  module InstanceMethods
    def initialize(name)
      @name = name
      @songs = []
    end

    def songs
      @songs
    end

    def save
      self.class.all << self
    end
  end

  module ClassMethods
    def destroy_all
      self.all.clear
    end

    def create(name)
      obj = self.new(name)
      obj.save
      obj
    end
  end
end
