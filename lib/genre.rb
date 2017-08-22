class Genre

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
    @@all << self
  end

  def self.create(name)
    genre = Genre.new(name)
    genre.save
    genre
  end

  def self.destroy_all
    @@all.clear
  end

  def find_song(song)
    @songs.find { |existing_song| existing_song.name == song.name }
  end

  def artists
    artists = []
    @songs.each do |song|
      artists << song.artist
    end
    artists.uniq
  end

end