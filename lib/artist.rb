class Artist

  extend Concerns::Findable

  attr_accessor :name, :songs, :genres
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.all
    @@all
  end

  def self.destroy_all
    self.all.clear
  end

  def save
    self.class.all << self
  end

  def self.create(name)
    new_artist = self.new(name)
    new_artist.save
    new_artist
  end

  def songs
    @songs
  end

  def add_song(song)
  self.songs << song if !self.songs.include?(song)
  song.artist=(self) if song.artist == nil
  end

  def genres
    self.songs.collect {|s| s.genre}.uniq
  end
end
