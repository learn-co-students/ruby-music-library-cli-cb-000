class Artist
  extend Concerns::Findable
  
  @@all = []

  attr_accessor :name

  def initialize(name)
    @name = name
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
    (artist = self.new(name)).save
    artist
  end

  def add_song(song)
    @songs << song unless @songs.include?(song)
    song.artist = self unless song.artist
  end

  def songs
    @songs
  end

  def genres
    all_genres = []
    @songs.collect do |songs|
      all_genres << songs.genre
    end
    all_genres.uniq
  end

end
