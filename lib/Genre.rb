class Genre
  attr_accessor :name
  extend Concerns::Findable
  @@all = []
  def initialize(name)
    @name = name
    @songs = []
  end
  def songs
    @songs
  end
  def self.all
    @@all
  end
  def self.destroy_all
    self.all.clear
  end
  def save
    @@all << self
  end
  def self.create(name)
    genre = Genre.new(name)
    @@all << genre
    genre
  end
  def artists
    self.songs.collect do |song|
      song.artist
    end.uniq
  end
end
