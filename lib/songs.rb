class Song

    attr_accessor :name, :artist, :genre

    @@all = []

    def initialize(name, artist=nil, genre=nil)
        @name = name
        self.artist=(artist) if artist
        self.genre=(genre) if genre
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
        song = Song.new(name)
        song.save
        song
    end

    def artist=(name)
        @artist = name
        name.add_song(self)
    end

    def genre=(name)
         @genre = name
         name.songs << self if !name.songs.include?(self)
    end

end
