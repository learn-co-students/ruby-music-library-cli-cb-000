class Artist

  extend Concerns::Findable

  attr_accessor :name, :songs, :genre

  @@genres = []
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def genres
    genres_array = []
    @songs.each do |song|
      genres_array << song.genre unless genres_array.include?(song.genre)
    end
    genres_array
  end

  def add_song(song)
    song.artist = self unless song.artist == self
    @songs << song unless @songs.include?(song)
  end

  def songs
    @songs
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

  def self.create(artist)
    artist = Artist.new(artist)
    artist.save
    artist
  end

end
