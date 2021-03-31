class Song
  attr_accessor :name, :artist, :genre

  @@all = []

  def initialize(name, artist=nil, genre=nil)
    @name = name
    self.artist = artist unless artist.nil?
    self.genre = genre unless genre.nil?
  end

  def save
    @@all << self
    self
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.add_song(self)
  end

  def self.new_from_filename(file_name)
    artist_name, song_name, genre_name = file_name.split(".mp3")[0].split(" - ")
    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre_name)
    song = Song.new(song_name, artist, genre)
  end

  def self.create_from_filename(file_name)
    self.new_from_filename(file_name).save
  end

  def self.find_by_name(name)
    song = @@all.detect{|song| song.name == name}
  end

  def self.find_or_create_by_name(name)
    song = @@all.detect{|song| song.name == name}
    if song.nil?
      song = self.create(name)
    end
    song
  end

  def self.create(name)
    self.new(name).save
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end
end
