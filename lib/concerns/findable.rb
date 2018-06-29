module Concerns
    module Findable
        def find_by_name(name)
            match = nil
            self.all.each {|item|
            if item.name == name
                match = item
            end}
            match
        end

        def find_or_create_by_name(name)
            item = find_by_name(name)
            if !item
                item = self.create(name)
            end
            item
        end
    end

end
