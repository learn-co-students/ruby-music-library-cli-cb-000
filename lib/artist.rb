class Artist
  extend Basics::ClassMethods
  extend Concerns::Findable
  include Basics::InstanceMethods

  attr_accessor :name, :songs

  @@all = []

  def initialize (name)
    super
    @songs=[]
  end

  def self.all
    @@all
  end

  def add_song(song)
    until self.songs.include?(song)
      self.songs << song
    end
    if song.artist != self
      song.artist = self
    end
  end

  def genres
    temp = []
    @songs.each do |s|
      temp << s.genre
    end
    temp.uniq
  end

end
