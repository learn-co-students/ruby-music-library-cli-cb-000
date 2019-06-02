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

    def self.find_by_name(name)
        self.all.detect{|song| song.name == name}
    end

    def self.find_or_create_by_name(name)
        song = self.find_by_name(name)
        song = self.create(name) if !song
        song
    end

    def self.new_from_filename(filename)
        parsed = filename.split(" - ")
        artist = parsed[0]
        song_title = parsed[1]
        genre = parsed[2].chomp(".mp3")
        new_song = self.find_by_name(song_title)

        if !new_song
            new_artist = Artist.find_or_create_by_name(artist)
            new_genre = Genre.find_or_create_by_name(genre)
            new_song = Song.new(song_title, new_artist, new_genre)
        end
    end

    def self.create_from_filename(filename)
        song = new_from_filename(filename)
        song.save
        song
    end

end
