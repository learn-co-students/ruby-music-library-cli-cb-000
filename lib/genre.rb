class Genre
  extend Concerns::Findable

  attr_accessor :name
  @@all = []

  def self.all
    @@all
  end

  def initialize(name = nil)
    @name = name
    @songs = []
  end

  def songs
    @songs
  end

  def artists
    array = []
    self.songs.each do |song|
      array << song.artist
    end
    array.uniq
  end

  def save
    @@all << self
  end

  def self.destroy_all
    all.clear
  end

  def self.create(name)
    new.tap {|genre| genre.name = name; genre.save}
  end
end
