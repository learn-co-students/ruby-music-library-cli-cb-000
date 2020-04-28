class Song
  
  attr_accessor :name
  attr_reader :artist, :genre
  
  @@all = []
  
  def initialize(name, artist = nil, genre = nil)
    
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
    
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
    song = Song.new(name)
    song.save
    song
  end
  
  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end
  
  def genre=(genre)
    @genre = genre
    genre.add_song(self)
  end
  
  def self.find_by_name(name)
    all.detect { |x| x.name == name}
  end
  
  def self.find_or_create_by_name(name)
    if self.find_by_name(name)
      self.find_by_name(name)
    else
      Song.create(name)
    end
    
  end
  
  def self.new_from_filename(filename)
    song_split = File.basename(filename,'.mp3').split(" - ")
    artist_name = song_split[0]
    song_name = song_split[1]
    genre_name = song_split[2]
    
    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre_name)
    Song.new(song_name, artist, genre)
  end
  
  def self.create_from_filename(name)
    new_from_filename(name).tap{ |x| x.save }
  end
  
end