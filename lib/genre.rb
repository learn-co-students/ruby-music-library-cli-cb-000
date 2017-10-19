require 'pry'

class Genre
  extend Concerns::Findable
  
  attr_accessor :name, :songs
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
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

  def self.create(name)
    self.new(name).tap(&:save)
  end

  def add_song(song)
    @genre = genre unless song.genre
    self.songs << song unless self.songs.include?(song)
  end

  def artists
    songs.collect(&:artist).uniq
  end
end
