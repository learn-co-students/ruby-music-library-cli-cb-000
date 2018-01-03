module Concerns
  module Memorable
    module ClassMethods

      def destroy_all
        self.all.clear
      end

      def create(name)
        self.all << self.new(name)
        self.new(name)
      end
    end

    module InstanceMethods

      def save
        self.class.all << self
      end
    end
  end
end
