# Genre class
class Genre
  @@all = []
  attr_accessor :name
  attr_reader :songs

  def initialize(name)
    @name = name
    @songs = []
  end

  #-------- Find --------#
  def artists
    songs.collect(&:artist).uniq
  end

  #-------- 001 --------#
  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def save
    @@all << self
  end

  def self.create(name)
    new(name).tap(&:save)
  end
end
