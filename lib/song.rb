class Song

attr_accessor :name
attr_reader :artist, :genre

@@all = []

def initialize(name, new_artist = nil, new_genre = nil)
  @name = name
  self.artist = new_artist if new_artist
  self.genre = new_genre if new_genre
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

def self.create(song)
  created_song = Song.new(song)
  created_song.save
  created_song
end

def artist=(artist)
  @artist = artist
  artist.add_song(self)
end

def genre=(genre)
  @genre = genre
  genre.add_song(self)
end

def self.new_from_filename(filename)
  file = filename.split(" - ")
    title = file[1]
    artist = Artist.find_or_create_by_name(file[0])
    new_genre = Genre.find_or_create_by_name(file[2].chomp(".mp3"))
  song = Song.new(title, artist, new_genre)
end

def self.create_from_filename(filename)
  new_from_filename(filename).tap{ |s| s.save }
end

def self.find_by_name(name)
  all.detect{|element| element.name == name}
end

def self.find_or_create_by_name(name)
  find_by_name(name) || create(name)
end

end
