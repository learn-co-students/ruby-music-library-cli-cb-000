class Artist
  extend Concerns::Findable
  
  attr_accessor :name
  attr_reader :songs

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.create(name)
    artist = Artist.new(name)
    artist.save
    artist
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all = []
  end

  def save
    self.class.all << self
  end

  def add_song(song)
    song.artist = self if !song.artist
    songs << song if !songs.include?(song)
  end

  def genres
    songs.collect { |song| song.genre }.uniq
  end

end
