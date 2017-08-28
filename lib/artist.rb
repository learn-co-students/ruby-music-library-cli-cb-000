class Artist
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

  def self.create(name)
    artist = self.new(name)
    @@all << artist
    artist
  end

  def add_song(song)
    if !(@songs.include?(song))
      @songs << song
      if song.artist == nil
        song.artist = self
      end
    end
  end

  def genres
    collection = []
    @songs.each do|song|
      if !(collection.include?(song.genre))
        collection << song.genre
      end
    end
    return collection
  end

end #close Artist Class call
