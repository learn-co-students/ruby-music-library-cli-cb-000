class Genre
    extend Concerns::Findable
    extend Persistable::ClassMethods
    extend Nameable::ClassMethods
    include Persistable::InstanceMethods

    @@all = []
    attr_accessor :name, :songs

    def initialize(name)
      @name = name
      @songs = []
    end

    def artists
      #Genre has many (artists) through songs 
      @songs.collect{|s| s.artist}.uniq
    end

    def self.all
      @@all
    end

  end
