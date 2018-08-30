class Genre
  extend Concerns::Findable
  attr_accessor :name, :songs
  @@all = []

  def initialize(name)
    @name = name
    @@all << self
    @songs = []
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all = []
  end

  def save
    @@all << Genre.new(name)
  end

  def self.create(name)
    new_genre = Genre.new(name)
    new_genre.save
    return new_genre
  end

  def songs
    @songs
  end

  def artists
    songs.map {|song| song.artist}.uniq
  end

  def add_song(song)
    songs << song if !songs.include?(song)
    song.genre = self if song.genre.nil?
  end
end
