class Song
  attr_accessor :name, :artist ,:genre

  extend Concerns::Findable

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    @@all << self
    self.artist = artist unless artist.nil?
    self.genre = genre unless genre.nil?
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
    new_song = Song.new(name)
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.add_song(self)
  end

  def self.find_by_name(song)
    @@all.detect {|i| i.name == song}
  end

  def self.find_or_create_by_name(song)
    self.find_by_name(song) == nil ? Song.create(song) : self.find_by_name(song)
  end

  def self.new_from_filename(song)
      file = song.chomp(".mp3").split(" - ")
      song = Song.new(file[1])
      song.artist = Artist.find_or_create_by_name(file[0])
      song.genre = Genre.find_or_create_by_name(file[2])
      song
  end

  def self.create_from_filename(song)
    self.new_from_filename(song)
  end

end
