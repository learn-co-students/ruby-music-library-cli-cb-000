module Concerns
  module Findable

    def find_by_name(name)
      x = false
      self.all.each do |subj|
        if subj.name == name
          x = subj
        end
      end
      x
    end

    def find_or_create_by_name(name)
      self.find_by_name(name) || self.create(name)
    end

    def create(name)
      x = self.new(name)
      return x
    end


  end
end
