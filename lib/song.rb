require 'pry'


class Song

  attr_accessor :name, :artist

  @@all = []

  def initialize(name, artist = nil)
    @name = name
    @artist = artist
  end

  def self.create(name)
    Song.new(name).save
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

  def artist=(artist)
    artist.add_song(self)
  end

end

#
# x = Song.new("oops")
# binding.pry
