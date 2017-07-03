class Genre
    attr_accessor :name, :songs
    extend Concerns::Findable

    @@all = []

    def initialize(name)
      self.name = name
      self.songs = []

    end

    def add_song(song)
      song.genre ||= self
      @songs << song unless @songs.include?(song)
  end

    def artists
      a = self.songs.collect {|s| s.artist}
      a.uniq


    end

    def self.all
      @@all
    end

    def self.destroy_all
      @@all.clear

    end

    def save
      @@all << self
      # @@all << self unless @@all.include?(self)
    end

    def self.create(name)
      # puts "about to save genre #{name}"
      # binding.pry
      genre = self.new(name)
      # genre = Genre.new(name)
      genre.save
      genre
    end
  end
