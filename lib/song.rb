class Song
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

end
