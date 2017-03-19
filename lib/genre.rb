class Genre
  attr_accessor :name, :songs
  @@all = []
  extend Concerns::Findable
  def initialize name
    @name = name
    @songs = []
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create name
    Genre.new(name).tap {|s| s.save}
  end

  def save
    self.class.all << self
  end

  def artists
    @songs.collect {|song| song.artist}.uniq
  end
end
