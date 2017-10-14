class Genre

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
    song.genre = self if song.genre == nil
  end
  end

  def artists
    songs.collect{|a|a.artist}.uniq
  end

  def self.all
    return @@all
  end

  def self.destroy_all
    @@all.clear
  end

def save
  self.class.all << self #unless @@all.include?(self)
end

def self.create(name)
  new_item = new(name)
  new_item.save
  new_item
end

end
