class Genre
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
    self.all.clear
  end

  def save
    Genre.all << self
    self
  end

  def self.create(name)
    genre = Genre.new(name)
    genre.save
  end

  def add_song(song)
    if !self.songs.include?(song)
      self.songs << song
    end
    if !song.genre
      song.genre = self
    end
  end

  def artists
    all_artists = self.songs.collect {|s| s.artist}
    all_artists.uniq
  end

  def to_s
    self.name
  end
end
