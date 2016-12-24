class Genre
  extend Concerns::Findable
  attr_accessor :name
  attr_reader :songs
  @@genres = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def artists
    self.songs.collect{|s| s.artist}.uniq
  end

  def save
    @@genres << self
  end

  def self.create(name)
    genre = Genre.new(name).tap { |genre| genre.save}
  end

  def self.all
    @@genres
  end

  def self.destroy_all
    @@genres.clear
  end
end
