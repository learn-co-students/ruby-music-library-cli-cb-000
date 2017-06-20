class Genre
  extend Concerns::Findable
  attr_accessor :name
  attr_reader :songs
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
    self.class.all << self
  end

  def add_song(song)
    if !(@songs.include?(song))
      @songs << song
    end
  end

  def self.create(name)
    genre = self.new(name)
    @@all << genre
    genre
  end

  def artists
    collection = []
    @songs.each do|song|
      if !(collection.include?(song.artist))
        collection << song.artist
      end
    end
    return collection
  end

end #close Genre Class
