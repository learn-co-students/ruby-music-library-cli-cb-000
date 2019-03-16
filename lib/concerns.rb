module Concerns
    module Findable #class methods
        def find_by_name(name)
            self.all.detect { |x| x.name == name}
        end


        def find_or_create_by_name(name)
            mySong = self.find_by_name(name)
            if (!mySong)
                mySong = self.create(name)
            end
            mySong
        end #find_or_create_by_name

        def ordered_list_sort
          i = 1;

          sorted = self.all.sort_by { |o| o.name}
          sorted.each { |x| puts("#{i}. #{x.name}"); i+=1}
          nil
        end
      end #module
end #Concerns
