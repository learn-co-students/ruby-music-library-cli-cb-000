class Genre
  extend Concerns::Findable
  attr_accessor :name, :songs
  
  @@all = []
  
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
  
 
  
  def self.create(name)
    genre = Genre.new(name)
    genre.save
    genre
  end
  
  def add_song(song)
    self.songs << song unless self.songs.include?(song)
    song.genre = self unless song.genre
  end
  
  def artists
    songs.collect { |x| x.artist}.uniq
  end 
 
  
end