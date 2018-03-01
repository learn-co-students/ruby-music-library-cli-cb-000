require 'pry'
class Song

  extend Concerns::Findable

  attr_accessor :name, :artist, :genre

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if !artist.nil?
    self.genre = genre  if !genre.nil?
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.add_song(self)
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

  def self.create(name)
    song = Song.new(name)
    song.save
    song
  end

  def self.find_by_name(name)
    @@all.find{|song| song.name == name}
  end

  def self.find_or_create_by_name(name)
    self.find_by_name(name) ? self.find_by_name(name) : self.create(name)
  end

  def self.new_from_filename(file)
    parse = file.split(/( - |\.)/)
    artist = Artist.find_or_create_by_name(parse[0])
    genre = Genre.find_or_create_by_name(parse[4])
    Song.new(parse[2], artist, genre)
  end

  def self.create_from_filename(file)
    song = self.new_from_filename(file)
    @@all << song
  end

end
