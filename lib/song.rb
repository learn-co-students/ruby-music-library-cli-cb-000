require 'pry'

class Song
  attr_accessor :name, :artist, :genre
  @@all = []

  def initialize(name, artist = nil, genre = nil)
     @name = name
     self.artist = artist if !artist.nil?
     self.genre = genre if !genre.nil?
  end

  def self.all
    @@all
  end

  def save
    @@all << self
  end

  def self.destroy_all
    @@all = []
  end

  def self.create(name)
    song = self.new(name)
    song.save
    song
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.songs << self unless genre.songs.include?(self)
  end

  def self.create_by_name(name)
    song = Song.new
    song.name = name
    @@all << song
    song
  end

  def self.find_by_name(name)
    self.all.detect {|song| song.name == name}
  end

  def self.find_or_create_by_name(name)
    if self.find_by_name(name) == nil
      self.create(name)
    else
      self.find_by_name(name)
    end
  end

  def self.new_from_filename(filename)
    var = filename.split(" - ")
    n = var[1]
    a = Artist.find_or_create_by_name(var[0])
    g =  Genre.find_or_create_by_name(var[2].gsub(".mp3",""))
    Song.new(n, a, g)
  end

  def self.create_from_filename(filename)
    self.new_from_filename(filename).save
  end
  
end
