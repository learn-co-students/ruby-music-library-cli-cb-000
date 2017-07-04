# Song class
class Song
  @@all = []
  attr_accessor :name
  attr_reader :artist, :genre

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end

  # Cutom setters enable relationships among objects
  def artist=(name)
    @artist = name
    name.add_song(self)
  end

  def genre=(name)
    @genre = name
    name.songs << self unless name.songs.include?(self)
  end

  #-------- 001 --------#
  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def save
    @@all << self
  end

  def self.create(name)
    new(name).tap(&:save)
  end
end
