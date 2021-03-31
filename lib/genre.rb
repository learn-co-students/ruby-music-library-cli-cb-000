class Genre
  extend Concerns::Findable
  attr_accessor :name

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
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
    self.new(name).tap { |genre| genre.save }
  end

  def songs
    @songs
  end

  def add_song(song)
    @songs << song unless @songs.include?(song)
  end

  def artists
    self.songs.collect { |song| song.artist }.uniq
  end

end
