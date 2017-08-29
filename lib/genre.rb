class Genre
  extend Concerns::Findable
  attr_accessor :name
  @songs = []
  @@all = []
    
  def initialize(name)
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

  def genre
    self
  end
  
  def artists
    @songs.collect { |song| song.artist }.uniq
  end
    
  def add_song(song)
    song.genre = self unless song.genre
    songs << song unless songs.include?(song)
  end
  
  def add_artist(artist)
    song.artist = self unless artist.genre
    artists << artist unless artists.include?(artist)
  end
end
