class Artist

  attr_accessor :name ,:songs
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all = []
  end

  def save
    @@all << self
  end

  def self.create(name)
    artist = Artist.new(name)
    artist.save
    artist
  end

  def add_song(song)
    unless @songs.include?(song)
      @songs << song
    end
    unless song.artist
      song.artist = self
    end
  end

  def genres
    @songs.map {|song| song.genre}.uniq
  end
end
