class Genre
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
    self.all.detect {|genre| genre.name == name}
  end

  def self.find_or_create_by_name(name)
    if genre = self.all.detect {|genre| genre.name == name}
      genre
    else
      genre = self.new(name)
      genre.save
      genre
    end
  end
  
  def self.destroy_all
    @@all.clear
  end

  def self.create(name)
    object = self.new(name)
    object.save
    object 
  end

  def add_song(song)
    if song.is_a?(Song) && !@songs.include?(song)
      @songs << song
      song.genre = self 
    end
  end

  def songs
    @songs
  end

  
  def artists
    artists = [] 
    @songs.each {|song| artists << song.artist unless song.artist == nil }
    artists.uniq
  end
  
end 
