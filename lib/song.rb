require "pry"
class Song
  extend Concerns::Findable

  attr_accessor :name, :artist, :genre
  @@all = []

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

  def self.create(name, artist = nil, genre = nil)
    new(name, artist, genre).tap {|s| s.save}
  end

  # OBJECT COLLABORATION METHODS

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.songs << self unless genre.songs.include?(self)
  end

  # OBJECT FINDERS

  def self.find_by_name(name)
    self.all.detect { |song| song.name == name }
  end

  def self.find_or_create_by_name(name)
    if self.find_by_name(name)
      self.find_by_name(name)
    else
      self.create(name)
    end
  end

  # CONSTRUCTOR
  def self.new_from_filename(filename)
    arr = filename.gsub(".mp3", " ").split(" - ")
    # binding.pry
    artist = Artist.find_or_create_by_name(arr[0].strip)
    genre = Genre.find_or_create_by_name(arr[2].strip)
    self.new(arr[1], artist, genre)
  end
  def self.create_from_filename(filename)
    arr = filename.gsub(".mp3", " ").split(" - ")
    artist = Artist.find_or_create_by_name(arr[0].strip)
    genre = Genre.find_or_create_by_name(arr[2].strip)
    self.create(arr[1], artist, genre)
  end

end
# binding.pry
