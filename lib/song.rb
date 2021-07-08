
class Song
  attr_accessor :name, :artist, :genre
  extend Concerns::Findable

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist unless artist.nil?
    self.genre = genre unless genre.nil?
  end

  def self.create(name)
    new = Song.new(name)
    new.save
    new
  end

  def self.new_from_filename(path)
    file = path.chomp(".mp3").split(" - ")
    song = Song.new(file[1])
    song.artist = Artist.find_or_create_by_name(file[0])
    song.genre = Genre.find_or_create_by_name(file[2])
    song.save
    song
  end

  def self.create_from_filename(path)
    self.new_from_filename(path)
  end

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
    @@all << self
  end

end
