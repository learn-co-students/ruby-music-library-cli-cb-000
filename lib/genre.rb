class Genre

  extend Concerns::Findable

  attr_accessor :name, :songs
  @@all = []

  def initialize name
    self.name = name
    self.songs = []
  end

  def save
    @@all << self
    self
  end

  def self.create name
    Genre.new(name).save
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def add_song song
    @songs << song unless @songs.include?(song)
    song.genre = self if song.genre.nil?
  end

  def artists
    self.songs.collect(&:artist).uniq
  end
end
