module Concerns
  module InstanceMethods

    def initialize (name)
        self.name = name
    end

    def save
      self.class.all << self
    end


  end
  module ClassMethods

    def create(name)
          self.new(name).tap { |object|
            object.save
          }
    end


    def destroy_all
      self.all.clear
    end

  end
end
