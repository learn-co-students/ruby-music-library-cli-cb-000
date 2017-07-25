require 'pry'
require_relative './genre.rb'
require_relative './song.rb'

class Artist
  extend Concerns::Findable
  attr_accessor :name
  attr_reader :songs

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  # add the song to the artist (has many) & the artist to the song (belongs to)
  def add_song(song)
    self.songs << song unless self.songs.include?(song)
    song.artist = self unless song.artist == self # belongs to
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

  # artist has many unique genres through songs
  def genres
    self.songs.collect{|song| song.genre}.uniq
  end

  def self.create(name)
    self.new(name).tap{|a| a.save}
  end
end

# binding.pry
