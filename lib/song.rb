class Song

attr_accessor :name, :artist, :genre

@@all = []


def initialize(name, artist = nil, genre = nil)
  @name = name
  if artist != nil
    self.artist = artist
  end
  if genre != nil
    self.genre = genre
  end
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
    song = self.new(name)
    @@all << song
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
     self.all.detect { |song| song.name == name }
   end

   def self.find_or_create_by_name(name)
    if self.find_by_name(name)
      self.find_by_name(name)
    else
      self.create(name)
    end
  end

  def self.new_from_filename(name)
       array = name.split(" - ")
       artist_name = array[0]
       artist = Artist.find_or_create_by_name(artist_name)
       title = array[1]
       genre_name = (array[2].chomp(".mp3"))
       genre = Genre.find_or_create_by_name(genre_name)
       new_song = Song.new(title, artist, genre)
  end

  def self.create_from_filename(name)
     new_song = self.new_from_filename(name)
     new_song.save
   end

end
