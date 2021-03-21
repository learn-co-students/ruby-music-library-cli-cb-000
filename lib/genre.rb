class Genre
  extend Concerns::Findable

  @@all = []

  attr_accessor :name
  attr_reader :songs

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.all
    @@all
  end

  def save
    @@all << self
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create(name)
    newInstance = self.new(name)
    newInstance.save
    newInstance
  end

  def artists
    songs.map do |song|
      song.artist
    end.uniq
  end

end
