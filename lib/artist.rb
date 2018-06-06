require 'pry'


class Artist

  attr_accessor :name

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end


  def songs
    @songs
  end

  def self.create(name)
    Artist.new(name).save
  end

  def add_song(song)
    if (song.artist == nil)
      # song.artist = self
      @songs << song
    end
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

end
