class Genre
  extend Memorable::ClassMethods, Concerns::Findable
  include Memorable::InstanceMethods

  @@all = []
  attr_accessor :songs

  def initialize(name)
    super
    @songs = []
  end

  def artists
    artists = []
    self.songs.each do |song|
      artists << song.artist unless artists.include? song.artist
    end
    return artists
  end

end
