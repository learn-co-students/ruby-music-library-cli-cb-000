class Genre
  
  attr_reader :name
  
  def initialize(name)
    @name = name
    @@all = []
    @songs = []
  end
  
  def name=(name)
    @name = name
  end
  
  def self.all
    return @@all
  end
  
  def self.destroy_all
    @@all = []
  end
  
  def save
    @@all << self
  end
  
  def self.create(name)
    newGenre = Genre.new(name)
    newGenre.save
    return newGenre
  end
  
  def songs
    return @songs
  end
  
  def artists
    collectorArray = []
    @songs.each do |song_element|
      collectorArray << song_element.artist
    end
    return collectorArray.uniq
  end
  
end