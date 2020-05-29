require 'pry'


class Artist
  extend Concerns::Findable
  attr_accessor :name
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
    @@all << self
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all = []
  end

  def save
    @@all << Artist.new(name)
  end

  def self.create(name)
    new_artist = Artist.new(name)
    new_artist.save
    return new_artist
  end

  def songs
    @songs
  end

  def genres
    songs.map {|song| song.genre}.uniq
  end

  def add_song(song)
    songs << song if !songs.include?(song)
    song.artist = self if song.artist.nil?
  end
end
