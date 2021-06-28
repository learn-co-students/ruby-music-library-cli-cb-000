require_relative 'concerns/findable'

class Song
  extend Concerns::Findable

  attr_accessor :name
  attr_reader :artist, :genre
  @@all = []

  def initialize(name, new_artist = nil, new_genre = nil)
    @name = name
    self.genre = new_genre if !new_genre.nil?
    self.artist = new_artist if !new_artist.nil?
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

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.add_song(self)
  end

  def self.create(name)
    temp = Song.new(name)
    temp.save
    temp
  end

  def self.new_from_filename(file)
    artist, song, genre = file.split(" - ")
    son = Song.find_or_create_by_name(song)
    son.artist = Artist.find_or_create_by_name(artist)
    son.genre = Genre.find_or_create_by_name(genre.chomp('.mp3'))
    son
  end

  def self.create_from_filename(filename)
    Song.new_from_filename(filename)
  end
end
