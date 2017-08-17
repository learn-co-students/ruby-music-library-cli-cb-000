class Artist
  attr_accessor :name
  attr_reader :songs
  extend Concerns::Findable

  @@all = []

  def initialize (name)
    @name = name
    @songs = []
  end

  def save
    self.class.all << self
  end

  def add_song (song)
    @songs << song if @songs.include?(song) == false
    song.artist = self if song.artist == nil
  end

  def genres
    genres = @songs.collect{|song| song.genre}
    genres.uniq
  end

  #________Class___Methods___________________

  def self.create (name)
    artist= Artist.new(name)
    self.all << artist
    artist
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all = []
  end
end
