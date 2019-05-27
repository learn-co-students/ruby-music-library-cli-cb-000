module Concerns

  module Findable
    def find_by_name(name) # Class finder
      self.all.detect { |object| object.name == name}
    end

    def find_or_create_by_name(name)
      self.find_by_name(name) ? self.find_by_name(name) : self.create(name)
    end    
  end

  module Memorable
    module ClassMethods
      def destroy_all
        self.all.clear
        #@@all.clear
      end

      def create(name)
        self.new(name).tap do |object|
          object.name = name
          object.save
        end
        #@name = name
        #song = self.new(name)
        #song.save
        #song
      end
    end

    module InstanceMethods
      def save
        self.class.all << self
        #@@all << self
      end
    end
  end

end
