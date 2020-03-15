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
    self.all.clear 
  end 
  
  def save 
    self.class.all << self 
  end 
  
  def self.create(name)
    genre = Genre.new(name)
    genre.save 
    genre 
  end 
  
  def songs 
    @songs 
  end 
  
  def artists 
    artist_array = []
    @songs.map do |song| 
      if artist_array.include?(song.artist)
        nil 
      else 
        artist_array << song.artist 
      end 
    end 
    artist_array
  end 
  
end 