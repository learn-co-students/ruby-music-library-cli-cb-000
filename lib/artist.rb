class Artist
  extend Memorable::ClassMethods, Concerns::Findable
  include Memorable::InstanceMethods

  @@all = []
  attr_accessor :songs

  def initialize(name)
    super
    @songs = []
  end

  def add_song(song)
    song.artist = self if song.artist == nil
    @songs << song unless @songs.include? song
  end

  def genres
    genres = []
    self.songs.each do |song|
      genres << song.genre unless genres.include? song.genre
    end
    return genres
  end

end
