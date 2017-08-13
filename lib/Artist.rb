class Artist

  extend Concerns::Findable

  attr_accessor :name, :songs
  @@all = []

  def initialize(name=nil)
    @name = name
    @songs = []
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def save
    @@all << self
  end

  def self.create(name=no_name)
    created = new(name)
    created.save
    created
  end

  def add_song(song)
    song.artist = self unless song.artist == self
    @songs << song unless @songs.include?(song)
  end

  def songs
    @songs
  end

  def genres
  	self.songs.collect{ |s| s.genre}.uniq
  end

end
