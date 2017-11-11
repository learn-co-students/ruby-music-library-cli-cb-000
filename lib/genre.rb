class Genre

  extend Concerns::Findable

  attr_accessor :name, :songs, :artist

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def artists
    artists_array = []
    @songs.each do |song|
      artists_array << song.artist unless artists_array.include?(song.artist)
    end
    artists_array
  end

  def add_song(song)
    @songs << song unless @songs.include?(song)
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

  def self.create(genre)
    genre = Genre.new(genre)
    genre.save
    genre
  end

end
