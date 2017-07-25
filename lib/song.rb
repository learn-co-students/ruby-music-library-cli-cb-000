require 'pry'
require_relative './genre.rb'
require_relative 'artist.rb'

class Song
  extend Concerns::Findable
  attr_accessor :name
  attr_reader :artist, :genre

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    # create 'belongs to' song belongs to artist/genre
    self.artist = artist unless artist == nil
    self.genre = genre unless genre == nil
  end

  # has many - artist has many songs
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
    self.all.clear
  end

  def save
    self.class.all << self
  end

  #constructor
  def self.create(name)
    self.new(name).tap{|s| s.save}
  end

  def self.new_from_filename(filename)
    items = filename.split(' - ')
    song = self.create(items[1])
    song.artist = Artist.find_or_create_by_name(items[0])
    song.genre = Genre.find_or_create_by_name(items[2].gsub('.mp3', ''))
    song
  end

  def self.create_from_filename(filename)
    self.new_from_filename(filename)
  end

  # def self.find_by_name(name)
  #   self.all.detect {|song| song.name == name}
  # end
  #
  # def self.find_or_create_by_name(name)
  #   song = self.find_by_name(name)
  #   (song)? song : self.create(name)
  # end

end

# binding.pry
