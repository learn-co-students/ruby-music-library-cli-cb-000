class Artist
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
    Artist.all << self
    self
  end

  def self.create(name)
    artist = Artist.new(name)
    artist.save
  end

  def add_song(song)
    if !self.songs.include?(song)
      self.songs << song
    end
    if !song.artist
      song.artist = self
    end
  end

  def genres
    all_genres = self.songs.collect {|s| s.genre}
    all_genres.uniq
  end

  def to_s
    self.name
  end

end
