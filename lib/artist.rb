#add requires
class Artist
  extend Concerns::Findable
  include Concerns::Sortable

  @@all = []
  attr_accessor :name, :songs

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all = []
  end

  def self.create(name)
    artist = self.new(name)
    artist.save
    artist
  end

  def save
    self.class.all << self
  end

  def add_song(song)
    song.artist = self unless song.artist
    self.songs << song unless self.songs.include?(song)
  end

  def genres
    self.songs.collect {|song| song.genre if song.genre }.uniq
  end

end
