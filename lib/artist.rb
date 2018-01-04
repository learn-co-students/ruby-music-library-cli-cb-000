class Artist
  extend Concerns::Memorable::ClassMethods
  include Concerns::Memorable::InstanceMethods
  attr_accessor :name, :songs
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.all
    @@all
  end

  def add_song(song)
    song.artist = self if song.artist == nil
    @songs << song if !@songs.include?(song)
  end

  def genres
    genres = @songs.collect {|song| song.genre}
    genres.uniq
  end

end
