module MusicModule


  module ClassMethods
    def self.all
      @@all
    end

    def self.destroy_all
      @@all.clear
    end
  end



  module InstanceMethods
    def initialize (name)
      @name = name
      @@all = []

    end

    def save
      @@all << self
    end
  end



end
