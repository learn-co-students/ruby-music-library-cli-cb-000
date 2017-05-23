class Song
  extend Concerns::ClassMethods
  extend Concerns::Findable
  include Concerns::InstanceMethods

  attr_accessor :name, :genre
  attr_reader :artist

  @@all = []

  def self.all
    @@all
  end

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self) unless @artist.songs.include?(self)
  end

  def genre=(genre)
    @genre = genre
    genre.songs << self unless genre.songs.include?(self)
  end

  def self.new_from_filename(file)
    filename = file.split(" - ")
    Song.new(filename[1],Artist.find_or_create_by_name(filename[0]),Genre.find_or_create_by_name(filename[2].split(".")[0]))
  end

  def self.create_from_filename(file)
    song = Song.new_from_filename(file)
    song.save
    song
  end

end
