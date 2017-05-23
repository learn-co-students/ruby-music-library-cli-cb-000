class Song
  extend Concerns::ClassMethods
  include Concerns::InstanceMethods

  attr_accessor :name, :artist, :genre

  @@all = []

  def self.all
    @@all
  end

  def initialize(name)
    super
  end

  def artist=(artist)
    @artist = artist
    @artist.add_song(self) unless !@artist.songs.include?(self)
  end

end
