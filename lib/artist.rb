class Artist
  extend Concerns::Findable

  attr_accessor :name, :songs, :song

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

  def songs
    @songs
  end

  def add_song(new_song)
    #add artist unless artist arleady == self
    new_song.artist = self unless new_song.artist != nil
    self.songs << new_song unless self.songs.include? new_song
  end

  def genres
    @songs.collect(&:genre).uniq
  end

end
