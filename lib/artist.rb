class Artist
  attr_accessor :name, :songs

  @@all = []

  def initialize(name)
    @name = name
    self.songs = []
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

  def songs
    @songs
  end

  def genres
    genres_array = @songs.collect{|s| s.genre}
    genres_array.uniq
  end

  def self.create(name)
    self.new(name).tap {|artist| artist.save}
  end

  def add_song(song, artist = nil)
    song.artist = self unless song.artist == self
    @songs << song unless @songs.include?(song)
  end
end
