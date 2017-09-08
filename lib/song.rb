require 'pry'

class Song

  extend Concerns::Findable

  attr_accessor :name
  attr_reader :artist, :genre

  @@all = []

  def artist=(artist)
    @artist = artist
    self.artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.songs << self unless genre.songs.include?(self)
  end

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist unless artist == nil
    self.genre = genre unless genre == nil
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

  def self.create(name)
    new_song = self.new(name)
    new_song.save
    new_song
  end

  def self.new_from_filename(filename)
    filename.chomp!('.mp3')
    artist, song, genre = filename.split(" - ")
    Song.new(song, Artist.find_or_create_by_name(artist), Genre.find_or_create_by_name(genre))
  end

  def self.create_from_filename(filename)
    Song.new_from_filename(filename).save
  end
end
