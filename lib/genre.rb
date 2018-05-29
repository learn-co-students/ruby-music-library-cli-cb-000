class Genre

  extend Concerns::Findable

  attr_accessor :name, :songs
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def artists
    artists = []
    self.songs.each do |hees|
      artists << hees.artist unless artists.include? hees.artist
    end
    return artists
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def save
    @@all << self
  end

  def self.create(genre)
    created_genre = self.new(genre)
    created_genre.save
    created_genre
  end

end
