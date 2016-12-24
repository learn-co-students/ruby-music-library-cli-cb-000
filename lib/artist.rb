class Artist
  extend Concerns::Findable
  attr_accessor :name
  attr_reader :songs
  @@artists = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def add_song(song)
    @songs << song if !@songs.include?(song)
    song.artist = self if song.artist == nil
  end

  def save
    @@artists << self
  end

  def genres
    self.songs.collect{|s| s.genre}.uniq
  end

  def self.create(name)
    artist = Artist.new(name).tap { |artist| artist.save}
  end

  def self.all
    @@artists
  end

  def self.destroy_all
    @@artists.clear
  end
end
