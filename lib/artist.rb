class Artist
  extend Concerns::Findable

  attr_accessor :genre, :songs, :name
  @songs = []
  @@all = []
  

  def initialize(name, genre=nil)
    setup
    @songs = []
    @name = name
    self.save
  end 

  def setup
      @@all  ||= []
  end

  def self.all
      @@all
  end

  def self.destroy_all
    @@all = []
  end

  def save
    @@all << self
  end

  def create(name)
    self.class.superclass.create(name)
  end

  def <=>(other)
    name <=> other.name
  end

  def to_s
    name
  end

  def songs
    @songs
  end 

  def genres
    @songs.collect { |song| song.genre }.uniq
  end 

  def add_song(song)
    song.artist = self unless song.artist
    songs << song unless songs.include?(song)
  end 
end
