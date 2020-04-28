class Song

  attr_accessor :name, :artist, :genre

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end

  def self.create(name)
   new_song = Song.new(name)
   new_song.save
   new_song
  end

  def save
   @@all << self
 end

 def artist=(artist)
   @artist = artist
   artist.add_song(self)
 end

 def genre=(genre)
   @genre = genre
   genre.add_song(self)
 end

 def self.all
   @@all
 end

 def self.destroy_all
   self.all.clear
 end

 def self.find_by_name(song)
   @@all.find { |x| x.name == song}
 end

 def self.find_or_create_by_name(song)
   self.find_by_name(song) || self.create(song)
 end

 def self.new_from_filename(path)
   file = path.chomp(".mp3").split(" - ")
   new_song = Song.new(file[1])
   new_song.artist = Artist.find_or_create_by_name(file[0])
   new_song.genre = Genre.find_or_create_by_name(file[2])
   new_song.save
   new_song
 end

 def self.create_from_filename(path)
   self.new_from_filename(path)
 end


end
