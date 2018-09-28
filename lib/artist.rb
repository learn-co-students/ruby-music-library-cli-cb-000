require 'pry'

class Artist
  extend Concerns::Findable

  @@all = []
  attr_accessor :name, :songs

  def initialize(name)
    self.name = name
    self.songs = []
    self.save
  end

  def self.all
    @@all
  end

  def self.destroy_all
    self.all.clear
  end

  def self.create(name)
    self.new(name).tap{|obj| obj.save}
  end

  def save
    self.class.all.push(self)
  end

  def add_song(song)
    self.songs.push(song) unless self.songs.include?(song)
    song.artist = self unless song.artist
  end

  def genres
    Song.all.select{|song| song.artist == self}.collect{|song| song.genre}.uniq
  end



end
