require "pry"
class Song
  extend Concerns::Findable
  attr_accessor :name, :artist, :genre

  @@all = []

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
    @@all << self
  end

  def self.create(name)
    self.new(name).tap { |song| song.save }
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.add_song(self)
  end

  def self.new_from_filename(filename)
    song_attr = filename[0..filename.length - 5].split(" - ")
    self.create(song_attr[1]).tap do |song|
      song.artist = Artist.find_or_create_by_name(song_attr[0])
      song.genre = Genre.find_or_create_by_name(song_attr[2])
    end
  end

  def self.create_from_filename(filename)
    self.new_from_filename(filename).tap { |song| song.save }
  end

end
