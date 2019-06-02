module Concerns
    module Findable
        def find_by_name(name)
            self.all.detect {|elem| elem.name == name}
        end

        def find_or_create_by_name(name)
            item = find_by_name(name)
            item = self.create(name) if !item
            item
        end
    end

end
