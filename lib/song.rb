require 'pry'
class Song

  extend Concerns::Findable

  attr_accessor :name, :genre, :artist
  attr_reader :artist

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    @genre = genre if genre == nil #genre.instance_of? String
    @artist = artist if artist == nil #artist.instance_of? String
  # @artist = artist if artist.instance_of? Artist
    self.artist=(artist) if artist != nil #artist.instance_of? Artist
    self.genre=(genre) if genre != nil #genre.instance_of? Genre
  end

  def genre=(genre)
    @genre = genre
    genre.add_song(self)
  end

  def artist=(artist)
      @artist = artist
      artist.add_song(self)
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

  def self.create(song)
    #binding.pry
    song = Song.new(song)
    song.save
    song
    #binding.pry
  end

#  def self.find_by_name(name)
#    @@all.detect do |song|
#      song.name == name
#    end
#  end

#  def self.find_or_create_by_name(name)
#    find = find_by_name(name)
#    if find.instance_of? Song
#      find
#    else
#      song = Song.create(name)
#      song
#    end
#  end

  def self.new_from_filename(filename)
    #binding.pry
    object_attributes_array = filename.split("-").map(&:strip)
    #binding.pry\
    object_attributes_array[2].slice! ".mp3"
    #new_artist = Artist.new(object_attributes_array[0])
    new_artist = Artist.find_or_create_by_name(object_attributes_array[0])
    #new_genre = Genre.new(object_attributes_array[2])
    new_genre = Genre.find_or_create_by_name(object_attributes_array[2])
    #binding.pry
    new_song = Song.new(object_attributes_array[1], new_artist, new_genre)
    #binding.pry
  end

  def self.create_from_filename(filename)
    song = new_from_filename(filename)
    song.save
  end
end
