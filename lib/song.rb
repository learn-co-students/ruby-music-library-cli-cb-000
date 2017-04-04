class Song
  extend Concerns::Findable
  attr_accessor :name
  attr_reader :artist, :genre

  @@all = []

  def initialize(name, artist=nil, genre=nil)
    @name = name
    @artist = artist
    @genre = genre
    self.artist = artist if artist != nil
    @genre = genre
    self.genre = genre if genre != nil

  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
 end

 def genre=(genre)
   @genre = genre
   self.genre.songs << self unless genre.songs.include?(self)
 end

  def save
    @@all << self
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create(name)
    song = Song.new(name)
    song.save
    song
  end

  def self.new_from_filename(filename)
    artist, song, genre = filename.sub(".mp3","").split(' - ')
    artist = Artist.find_or_create_by_name(artist)
    genre = Genre.find_or_create_by_name(genre)
    new_song = self.new(song, artist, genre)
    new_song
  end

  def self.create_from_filename(filename)
    new_song = self.new_from_filename(filename)
    new_song.save
    new_song
  end

end
