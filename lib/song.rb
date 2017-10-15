class Song
  extend Concerns::Findable, Memorable::ClassMethods
  include Memorable::InstanceMethods

  attr_accessor :name
  attr_reader :artist, :genre
  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    @songs = []
    self.artist = artist if artist
    self.genre = genre if genre
  end

  def self.all
    @@all
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
    song_data = filename.chomp(".mp3").split(" - ")

    song_name = song_data[1]
    artist = Artist.find_or_create_by_name(song_data[0])
    genre = Genre.find_or_create_by_name(song_data[2])

    new_song = self.new(song_name, artist, genre)
    new_song
  end

  def self.create_from_filename(filename)
    song = self.new_from_filename(filename)
    song.save
  end
end
