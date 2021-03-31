class Genre
  attr_accessor :name, :songs
  @@all = []
  extend Concerns::Findable


  def initialize(name)
    @name = name
    @songs = []
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

  def artists
    artists = self.songs.collect{|song| song.artist}
    artists.uniq
  end

  def self.create(name)
    self.new(name).tap{|genre| genre.save}
  end
end
