class Artist
  extend Concerns::ClassMethods
  include Concerns::InstanceMethods

  attr_accessor :name, :songs

  @@all =  []

  def self.all
    @@all
  end

  def initialize (name)
    super
    @songs = []
  end

  def add_song (song)
    @songs << song
    song.artist = (self) unless song.artist == self
  end


end
