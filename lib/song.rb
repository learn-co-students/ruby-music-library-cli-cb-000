class Song
  extend Concerns::ClassMethods
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

end
