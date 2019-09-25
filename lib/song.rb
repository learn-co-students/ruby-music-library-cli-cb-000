class Song
  include Comparable

  attr_accessor :name
  attr_reader   :artist, :genre
  @@all = []

  def initialize(name, artist = nil, genre = nil)
    self.name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end

  def <=>(other)
    self.name <=> other.name
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all = []
  end

  def save
    @@all << self
  end

  def self.create(name)
    Song.new(name).tap { |song| song.save }
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.add_song(self) unless genre.songs.map do |song|
      song.name
    end.include?(self.name)
  end

  def self.find_by_name(name)
    self.all.detect { |song| song.name == name }
  end

  def self.find_or_create_by_name(name)
    song = Song.find_by_name(name)
    if song.nil?
      Song.create(name)
    else
      song
    end
  end

  def self.new_from_filename(filename)
    artist, name, genre = filename.split(' - ')
    Song.new(name,
      Artist.find_or_create_by_name(artist),
      Genre.find_or_create_by_name(genre[0..-5]))
  end

  def self.create_from_filename(filename)
    self.new_from_filename(filename).tap { |song| song.save }
  end
end
