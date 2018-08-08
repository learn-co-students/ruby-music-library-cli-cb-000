require 'pry'

class Song
  def self.new_from_filename(filename)
    f = filename.split(' - ')
    name = f[1]
    artist = Artist.find_or_create_by_name(f[0])
    genre = Genre.find_or_create_by_name(f[2].gsub('.mp3', ''))
    # genre = 'a'
    new(name, artist, genre)
  end

  def self.create_from_filename(filename)
    song = new_from_filename(filename)
    song.save
  end

  @@all = []

  attr_accessor :name
  attr_reader :artist, :genre

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
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

  def self.create(name)
    newInstance = self.new(name)
    newInstance.save
    newInstance
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.songs << self unless genre.songs.include? self
  end

  def self.find_by_name(name)
    all.find do |song|
      song.name == name
    end
  end

  def self.find_or_create_by_name(name)
    if find_by_name(name)
      find_by_name(name)
    else
      create(name)
    end
  end
end
