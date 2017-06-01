module Concerns
  module Findable
    module ClassMethods
      def find_by_name(name)
        if self.all == nil
          self.destroy_all
        end
        return self.all.detect{|element| element.name == name}
      end
      def find_or_create_by_name(name)
        returned_item = self.find_by_name(name)
        if returned_item == nil
          returned_item = self.new(name)
        end
        return returned_item
      end
    end

    module InstanceMethods
    end
  end
end
