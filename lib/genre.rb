class Genre
  extend Basics::ClassMethods
  extend Concerns::Findable
  include Basics::InstanceMethods

  attr_accessor :name, :songs

  @@all = []

  def initialize (name)
    super
    @songs = []
  end

  def self.all
    @@all
  end

  def add_song(song)
    until self.songs.include?(song)
      self.songs << song
    end
    if song.genre != self
      song.genre = self
    end
  end

  def artists
    temp = []
    @songs.each do |s|
      temp << s.artist
    end
    temp.uniq
  end

end
