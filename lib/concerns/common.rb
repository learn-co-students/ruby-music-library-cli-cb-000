
module Concerns
  module Common
    module InstanceMethods
      def initialize(name)
        @name = name
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
        self.new(name).tap {|g| g.save}
      end
    end
  end
end
