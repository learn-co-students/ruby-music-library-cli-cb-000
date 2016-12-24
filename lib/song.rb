require "pry"
class Song
  extend Concerns::Findable
  attr_accessor :name
  attr_reader :artist,:genre
  @@songs = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist
    self.genre = genre
  end

  def genre=(genre)
    if genre.instance_of?(Genre)
      @genre = genre
      self.genre.songs << self if !self.genre.songs.include?(self)
    end
  end

  def artist=(artist)
    if artist.instance_of?(Artist)
      @artist = artist
      self.artist.add_song(self)
    end
  end

  def save
    @@songs << self
  end

  def self.create(name)
    song = Song.new(name).tap { |song| song.save}
  end

  def self.new_from_filename(file)
    data = file.split(" - ")
    song = Song.new(data[1])
    song.artist = Artist.find_or_create_by_name(data[0])
    song.artist.add_song(song)
    song.genre = Genre.find_or_create_by_name(data[2].slice(0,data[2].length-4))
    song
  end

  def self.create_from_filename(file)
    song = self.new_from_filename(file)
    song.save
    song
  end

  def self.all
    @@songs
  end

  def self.destroy_all
    @@songs.clear
  end

end
