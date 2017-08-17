class Artist

  attr_accessor :name

  def initialize(name)
    @name = name
  end

  @@all = []

  def self.all
    @@all
  end

  def save
    @@all << self
  end

  def self.create(name)
    artist = Artist.new(name)
    artist.save
    artist
  end

  def self.destroy_all
    @@all.clear
  end

end