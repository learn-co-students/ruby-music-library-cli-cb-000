module Concerns
  module Findable

    def find_by_name(name)
      self.all.detect {|e| e.name == name}
    end

    def find_or_create_by_name(name)
      self.find_by_name(name) ? self.find_by_name(name) : self.create(name)
    end

  end

  module Memorable
    module ClassMethods

      def destroy_all
        self.all.clear
      end

      def create(name)
        new_instance = self.new(name)
        self.all << new_instance
        new_instance
      end
    end

    module InstanceMethods

      def save
        self.class.all << self
      end
    end
  end
end
