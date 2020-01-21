class Genre
  attr_accessor :name, :songs
  extend Concerns::Findable

  @@all = []

  def initialize (name)
    @name = name
    @songs = []
  end

  def save
    self.class.all << self
  end

  def artists
    artists = @songs.collect{|song| song.artist}
    artists.uniq
  end

  #________Class___Methods___________________

  def self.create (name)
    genre= Genre.new(name)
    self.all << genre
    genre
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all = []
  end
end
