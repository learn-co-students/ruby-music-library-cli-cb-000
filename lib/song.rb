require 'pry'

class Song

  attr_accessor :name, :songs, :artist, :genre

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    @artist = artist
    unless artist == nil
      artist.add_song(self)
    end
    @genre = genre
    unless genre == nil
      genre.add_song(self)
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

  def self.create(name)
    song = Song.new(name)
    song.save
    song
  end

  def artist=(artist)
    @artist = artist
    @artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    @genre.add_song(self)
  end

  def self.find_by_name(name)
    self.all.detect{|i| i.name == name}
  end

  def self.find_or_create_by_name(song_name)
    self.find_by_name(song_name) || self.create(song_name)
  end

  def self.new_from_filename(file_name)
    array = file_name.split(" - ")
    name = array[1]
    artist = Artist.find_or_create_by_name(array[0])
    genre = Genre.find_or_create_by_name(array[2].chomp(".mp3"))
    @song = Song.new(name, artist, genre)
    @song
  end

  def self.create_from_filename(filename)
    array = filename.split(" - ")
    name = array[1]
    artist = Artist.find_or_create_by_name(array[0])
    genre = Genre.find_or_create_by_name(array[2].chomp(".mp3"))
    @song = Song.new(name, artist, genre)
    @song.save
    @song
  end






end
