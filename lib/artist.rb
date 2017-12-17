require_relative 'concerns/findable.rb'
require 'pry'

class Artist
  extend Concerns::Findable

  attr_accessor :name, :songs

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.all
    @@all
  end

  def save
    @@all << self
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create(name)
    temp = Artist.new(name)
    temp.save
    temp
  end

  def add_song(song)
    @songs << song if !@songs.include?(song)
    song.artist = self if song.artist.nil?
  end

  def genres
    genres = []
    @songs.each {|song| genres << song.genre}
    genres.uniq
  end
end
