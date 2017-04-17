
class Song
  extend Concerns::Findable
  attr_accessor :name, :artist, :genre
  @@all=[]
  def initialize(name, artist=Artist.new("Unknown"), genre=Genre.new("Unknown"))
    @name=name
    self.artist=artist
    self.genre = genre
  end
  def self.create(name)
    Song.new(name).tap{|s|s.save}
  end

  def self.all
    @@all
  end
  def save
    @@all << self
  end
  def artist=(artist)
    @artist = artist
    artist.add_song(self) unless artist.songs.include?(self)
  end

  def self.destroy_all
    @@all.clear
  end

  def genre=(genre)
    @genre = genre
    genre.songs << self unless genre.songs.include?(self)
  end

  def self.new_from_filename(filename)
    strings = filename.split(" - ")
    artist = Artist.find_or_create_by_name(strings[0])
    genre = Genre.find_or_create_by_name(strings[2].split(".")[0])
    Song.new(strings[1],artist,genre)
  end

  def self.create_from_filename(filename)
    song = self.new_from_filename(filename)
    song.save
    song
  end

  # def self.find_by_name(name)
  #   self.all.detect{|s|s.name==name}
  # end
  #
  # def self.find_or_create_by_name(name)
  #   self.find_by_name(name) ? self.find_by_name(name) : Song.create(name)
  # end
end
