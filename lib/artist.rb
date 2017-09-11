class Artist
  attr_accessor :name 
  @@all = [] 

  def initialize(name) 
    @name = name
    @songs = []
  end
  
  def save
    @@all << self 
  end

  def self.all
    @@all
  end

  def self.find_by_name(name)
    self.all.detect {|artist|  artist.name == name}
  end

  def self.find_or_create_by_name(name)
    if artist = self.all.detect {|artist| artist.name == name}
      artist
    else
      artist = self.new(name)
      artist.save
      artist 
    end
      
  end
  def self.destroy_all
    @@all.clear
  end

  def self.create(name) 
    object = self.new(name) 
    @@all << object
    object
  end

  def add_song(song)
    if song.is_a?(Song) && !@songs.include?(song)
      @songs << song 
      song.artist = self
    end
  end

  def songs
    @songs
  end

  
  
  def genres
    genres = []
    @songs.each {|song| genres << song.genre unless song.genre == nil}
    genres.uniq
  end 
end
