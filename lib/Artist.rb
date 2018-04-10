class Artist
  extend Concerns::Findable

  attr_accessor :name
  attr_reader :songs
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.all
    @@all
  end

  def save
#    @@all << self
    self.class.all << self
  end

  def self.destroy_all
    self.all.clear
  end

  def self.create(name)
    #artist = Artist.new(name)
    artist = new(name)
    artist.save
    artist
  end

  def add_song(song)
#    if song.artist == nil
#      song.artist = self
#    end
#    unless self.songs.include?(song)
#      self.songs << song
#    end
#or
    song.artist = self unless song.artist
    songs << song unless songs.include?(song)
#end or
  end

  def genres
    self.songs.collect { |song| song.genre }.uniq
  end

end
