class Song
  extend Concerns::Findable
  extend Concerns::Memorable::ClassMethods
  include Concerns::Memorable::InstanceMethods
  attr_accessor :name
  attr_reader :artist, :genre
  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    artist != nil ? self.artist = artist : @artist = artist
    genre != nil ? self.genre = genre : @genre = genre
  end

  def self.all
    @@all
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.add_song(self)
  end

  def self.new_from_filename(filename)
    filename = filename.split(" - ")
    song = Song.new(filename[1], Artist.find_or_create_by_name(filename[0]), Genre.find_or_create_by_name(filename[2].split(".mp3")[0]))
    song
  end

  def self.create_from_filename(filename)
    song = self.new_from_filename(filename)
    song.save
    song
  end
end
