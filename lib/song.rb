require 'pry'
class Song
  attr_accessor :name, :artist, :genre

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end

  def self.create(song, artist = nil, genre = nil)
    self.new(song, artist, genre).tap{|song| song.save}
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

  def artist=(artist) #artist instance Artist class
     @artist = artist
     artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.songs << self unless genre.songs.include?(self)
  end

  def self.find_by_name(name)
    @@all.find{|s| s.name == name}
  end

  def self.find_or_create_by_name(name)
    self.find_by_name(name) ? self.find_by_name(name) : self.create(name)
  end

  def self.new_from_filename(name)
    parsed_name = name.split(" - ")
    parsed_artist = parsed_name[0]
    song = self.new(parsed_name)
    song.name = parsed_name[1].split(".")[0]
    song.artist = Artist.find_or_create_by_name(parsed_artist)
    song.genre = Genre.find_or_create_by_name(File.basename(parsed_name[parsed_name.length - 1], ".*"))
    song
  end

  def self.create_from_filename(name)
    new_from_filename(name).tap {|song| song.save}
  end
end
