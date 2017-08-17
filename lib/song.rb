class Song
  extend Findable
  
  attr_accessor :artist, :genre, :name

  def initialize(song_name, artist = nil, genre = nil)
    # binding.pry
    Song.setup
    @name=song_name
    self.artist = artist if artist
    self.genre = genre if genre
  end
    
  def artist=(artist)
    if artist.is_a?(Artist)
      @artist = artist
      artist.add_song(self)
    else
      Artist.find_or_create_by_name(artist)
    end
  end 
    
  def genre=(genre)
    if genre.is_a?(Genre)
      @genre = genre
      genre.add_song(self)
    else
      Genre.find_or_create_by_name(genre)
    end
  end 
    
  def self.new_from_filename(filename)
    song_name = filename.split(/ - /)[1]
    singer = filename.split(/ - /)[0]
    music_type = filename.split(/ - /)[2].lstrip
    music_type = music_type[0,music_type.length-4]
    artist = Artist.find_or_create_by_name(singer)
    genre = Genre.find_or_create_by_name(music_type)
    self.new(song_name, artist, genre)
  end
    
  def self.create_by_filename(filename)
    self.new_from_filename(filename)
  end 

  def self.create_from_filename(filename)
    self.new_from_filename(filename)
  end

  def self.new_by_filename(filename)
    self.new_from_filename(filename)
  end
end 
