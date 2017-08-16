class Artist
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
    @@all.clear
  end

  def save
    @@all << self
  end

  def self.create(name)
    artist = self.new(name)
    artist.save
    artist
  end

  def add_song(song)
    songs << song unless songs.any? {|s| s == song}
    song.artist = self unless (song.artist != nil || song.artist == self)
  end

  def genres
    genres = []
    songs.each {|s| genres << s.genre}
    genres.uniq
  end

end
