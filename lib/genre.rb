class Genre
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
    song.genre = self if song.genre == nil
    @songs << song if !@songs.include?(song)
  end

  def artists
    artists = @songs.collect {|song| song.artist}
    artists.uniq
  end

end
