class Artist

  extend Concerns::Findable

  attr_accessor :name
  attr_reader :songs

  def initialize(name)
    @name = name
    @songs = []
  end

  @@all = []

  def self.all
    @@all
  end

  def save
    @@all << self
  end

  def self.create(name)
    artist = Artist.new(name)
    artist.save
    artist
  end

  def self.destroy_all
    @@all.clear
  end

  def add_song(song)
    @songs << song unless find_song(song)
    song.artist = self unless song.artist == self
  end

  def genres
    genres = []
    @songs.each do |song|
      genres << song.genre
    end
    genres.uniq
  end

  def find_song(song)
    @songs.find { |existing_song| existing_song.name == song.name }
  end

end