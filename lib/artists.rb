class Artist

  extend Concerns::Findable

  attr_accessor :name
  attr_reader :songs

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def add_song(song)
    unless @songs.include?(song)
    @songs << song
    song.artist = self if song.artist == nil
  end
  end


  def self.all
    return @@all
  end

  def self.destroy_all
    @@all.clear
  end

def save
  self.class.all << self unless @@all.include?(self)
end

def self.create(name)
  new_item = new(name)
  new_item.save
  new_item
end

def genres
  songs.collect{|a|a.genre}.uniq
end

end
