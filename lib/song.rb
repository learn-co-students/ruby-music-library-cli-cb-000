class Song
  attr_accessor :name
  attr_reader :genre, :artist  
  
  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    if artist.is_a?(Artist) 
      self.artist = artist 
      artist.add_song(self)
      
    end
    
    if genre.is_a?(Genre)
      self.genre = genre 
      genre.add_song(self)
    
    end
    
  end
  
  def self.destroy_all
    @@all.clear 
  end

  def save
    @@all << self
  end

  #constructors
  
  def self.create(name)
    song = self.new(name) 
    song.save
    song
  end

  def self.new_from_filename(filename)
    parts = filename.sub(".mp3","").split(" - ")
    artist = Artist.find_or_create_by_name(parts[0])
    genre = Genre.find_or_create_by_name(parts[2])
    song = Song.new(parts[1], artist, genre )
    song
  end

  def self.create_from_filename(filename)
    parts = filename.sub(".mp3","").split(" - ")
    artist = Artist.find_or_create_by_name(parts[0])
    genre = Genre.find_or_create_by_name(parts[2])
    song = Song.new(parts[1], artist, genre)
    song.save
    song
  end
  
  def self.all
    @@all
  end
  #adding find methods
  
  extend Concerns::Findable
  
  def artist
    @artist
  end
  
  def artist=(artist)
    if artist.is_a?(Artist) && @artist == nil 
      @artist = artist
      artist.add_song(self) 
    end
  end

  def genre=(genre)
    if genre.is_a?(Genre) && @genre == nil 
      @genre = genre
      genre.add_song(self)
    end
  end

  
end
