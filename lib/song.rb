# Song class
class Song
  extend Concerns::Findable
  @@all = []
  attr_accessor :name
  attr_reader :artist, :genre
  #-------- Initialize --------#
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
    name.songs << self unless @genre.songs.include?(self)
  end
  #-------- Find --------#
  def self.find_by_name(name)
    all.detect { |song| song.name == name }
  end

  def self.find_or_create_by_name(name)
    find_by_name(name) || create(name)
  end
  #-------- Memorable --------#
  def self.all
    @@all
  end

  def self.destroy_all
    all.clear
  end

  def save
    self.class.all << self
  end

  def self.create(name)
    new(name).tap(&:save)
  end
end
