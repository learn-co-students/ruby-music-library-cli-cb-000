# Artist class
class Artist
  @@all = []
  attr_accessor :name
  attr_reader :songs

  def initialize(name)
    @name = name
    @songs = []
  end

  def add_song(song)
    song.artist = self if song.artist.nil?
    @songs << song unless @songs.include?(song)
  end

  #-------- Find --------#
  def genres
    songs.collect(&:genre).uniq
  end

  #-------- 001 --------#
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
    new(name).tap(&:save)
  end
end
