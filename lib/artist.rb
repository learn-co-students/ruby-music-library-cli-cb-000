class Artist

    extend Concerns::Findable

    attr_accessor :name, :songs

    @@all = []

    def initialize(name)
        @name = name
        @songs = []
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

    def save
        @@all << self
    end

    def self.create(name)
        artist = Artist.new(name)
        artist.save
        artist
    end

    def add_song(song)
        song.artist = self if !song.artist
        @songs << song if !@songs.include?(song)
    end

    def genres
        genre_collection = []
        @songs.each do |song|
            genre_collection << song.genre if !genre_collection.include?(song.genre)
        end
        genre_collection
    end

end
