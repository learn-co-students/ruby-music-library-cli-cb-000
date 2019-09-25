class Genre
  extend Concerns::Findable
  include Comparable

  attr_accessor :name
  attr_reader   :songs
  @@all = []

  def initialize(name)
    self.name = name
    @songs = []
  end

  def <=>(other)
    self.name <=> other.name
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all = []
  end

  def save
    @@all << self
  end

  def self.create(name)
    Genre.new(name).tap { |genre| genre.save }
  end

  def add_song(song)
    @songs << song unless @songs.map do |song|
      song.name
    end.include?(song.name)
  end

  def artists
    self.songs.map { |song| song.artist }.uniq
  end
end
