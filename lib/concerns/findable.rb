module Concerns
  module Findable

    def self.find_by_name(genre)
      all.detect{|element| element.name == name}
    end

  end

end
