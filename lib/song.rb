require 'pry'

class Song
  attr_accessor :name, :artist, :genre
  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist
    self.genre = genre
  end

  def self.all # Can be abstracted into a module
    @@all
  end

  def self.destroy_all # Can be abstracted into a module
    @@all.clear
  end

  def save
    self.class.all << self
  end

  def self.create(name) # Custom constructor
    self.new(name).tap(&:save)
  end

  def artist=(artist)
    if artist
      @artist = artist
      artist.add_song(self)
    end
  end

  def genre=(genre)
    if genre
      @genre = genre
      genre.add_song(self)
    end
  end
end
