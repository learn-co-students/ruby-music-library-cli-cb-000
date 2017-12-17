require_relative 'concerns/findable.rb'
require 'pry'

class Genre
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
    temp = Genre.new(name)
    temp.save
    temp
  end

  def add_song(song)
    @songs << song if !@songs.include?(song)
    song.genre = self if song.genre.nil?
  end

  def artists
    artists = []
    @songs.each {|song| artists << song.artist}
    artists.uniq
  end
end
