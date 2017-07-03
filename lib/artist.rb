
class Artist
# require 'pry'
extend Concerns::Findable
attr_accessor :name, :songs
  @@all = []


  def initialize(name)
    @name = name
    @songs = []
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear

  end


  def genres
    g = self.songs.collect {|s| s.genre}
    # take array of songs, collect all genres from songs, and deduplicate
    g.uniq
    # self.songs.uniq
  end

  def save
    @@all << self
    # @@all << self unless @@all.include?(self)
  end

  def self.create(name)
    # artist = Artist.new(name)
    artist = self.new(name)
    artist.save
    artist
  end

  def add_genre(genre)
    @genres << genre unless @genres.include?(genre)
  end

  def add_song(song)
    song.artist ||= self
    @songs << song unless @songs.include?(song)
  end
end
