require 'pry'
class Song

  attr_accessor :name, :artist, :genre
  extend Concerns::Findable
  @@songs = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist != nil
    self.genre = genre if genre != nil
  end

  def self.all
    @@songs
  end

  def save
    self.class.all << self
  end

  def self.destroy_all
    self.all.clear
  end

  def self.create(name)
    song = self.new(name)
    song.save
    song
  end

  def artist=(name)
    @artist = name
    @artist.add_song(self)
  end

  def genre=(name)
    @genre = name
    @genre.songs << self if @genre.songs.none? {|e| e == self}
  end

  def self.new_from_filename(filename)
    filename = filename.chomp(".mp3")
    farr = filename.split(" - ")
    song = self.new(farr[1], Artist.find_or_create_by_name(farr[0]), Genre.find_or_create_by_name(farr[2]))
  end

  def self.create_from_filename(filename)
    song = self.new_from_filename(filename)
    song.save
    song
  end

  def self.print_songs
    arr= []
    self.all.each {|e| arr << "#{e.artist.name} - #{e.name} - #{e.genre.name}"}
    arr.sort
  end

end
