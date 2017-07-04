# Song class
class Song
  @@all = []
  attr_accessor :name

  def initialize(name)
    @name = name
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
