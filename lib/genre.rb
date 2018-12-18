class Genre
  extend Concerns::Findable
  attr_accessor :name, :songs
  @@all = []
  def self.all
    @@all
  end
  def self.destroy_all
    @@all = []
  end
  def initialize(name)
    @name = name
    @songs = []
  end
  def save
    @@all << self
  end
  def self.create(name)
    genre = self.new(name)
    genre.save
    genre
  end
  def artists
    value  = @songs.collect do |song|
      song.artist
    end
    value.uniq
  end
end
