module Concerns
  module Findable
    def destroy_all
      self.all.clear
    end

    def create(name)
      self.new(name).save
    end

    def find_by_name(name)
      self.all.detect {|e| e.name == name}
    end

    def find_or_create_by_name(name)
      find = find_by_name(name)
      return find if find
      self.create(name)
    end
  end

end
