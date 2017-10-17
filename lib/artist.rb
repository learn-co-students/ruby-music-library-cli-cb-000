require 'pry'

class Artist
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
    songs << song unless songs.include?(song)
  end

  def genres # returns genres > eg. [punk, rock]
    songs.collect do |song|
      song.genre
    end
  end
end
