module Concerns

  module Findable
    def find_by_name(name)
      self.all.find{|object| object.name == name}
    end

    def find_or_create_by_name(name)
      search = find_by_name(name)
        if find_by_name(name).is_a?(self)
          return search
        else
          self.create(name)
        end
    end
  end

  module InstanceMethods


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
