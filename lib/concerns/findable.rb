module Concerns
  module Findable

    def find_by_name(name)
      self.all.detect{|song| song.name == name}
    end

    def find_or_create_by_name(name)
      if self.find_by_name(name) == nil
        self.create(name)
      else
        self.find_by_name(name)
      end
    end

  end

end

# Teacher solution

# module Concerns::Findable
#   def find_by_name(name)
#     all.detect{ |o| o.name == name }
#   end
#
#   def find_or_create_by_name(name)
#     find_by_name(name) || create(name)
#   end
# end
