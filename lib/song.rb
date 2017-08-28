class Song

  attr_accessor :name
  attr_reader :artist, :genre

  @@all = []

  def initialize name, artist=nil, genre=nil
    self.name = name
    artist.add_song self unless artist.nil?
    genre.add_song self unless genre.nil?
  end

  def save
    @@all << self
    self
  end

  def self.create name
    Song.new(name).save
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.add_song(self)
  end

  def self.find_by_name name
    self.all.detect{ |song| song.name == name }
  end

  def self.find_or_create_by_name name
   self.find_by_name(name) || self.create(name)
 end

 def self.new_from_filename file_name
   file_name_array = file_name.split(" - ")
   song_artist = Artist.find_or_create_by_name file_name_array[0]
   song_name = file_name_array[1]
   song_genre = Genre.find_or_create_by_name file_name_array[2].gsub(".mp3", "")
   Song.new(song_name, song_artist, song_genre)
 end

 def self.create_from_filename file_name
   song = self.new_from_filename file_name
   song.save
 end



end
