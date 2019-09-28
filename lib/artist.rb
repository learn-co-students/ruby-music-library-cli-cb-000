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
    @@all.clear
  end

  def save
    @@all << self
  end

  def self.create(name)
    song = Artist.new(name)
    song.save
    song
  end

  def add_song(song)
      @songs << song if !@songs.include?(song)
      song.artist = self if song.artist == nil
      song
  end

  def genres
    genres = @songs.collect {|song| song.genre}
    genres.uniq
  end

end
