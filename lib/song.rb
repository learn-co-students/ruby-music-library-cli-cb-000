class Song
  extend Concerns::Findable

  attr_accessor :name, :artist, :genre

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist unless artist == nil
    self.genre = genre unless genre == nil
    self.save
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.add_song(self)
  end

  def save
    self.class.all << self unless self.class.all.detect {|song| song.name == self.name}
  end

  def self.all
    @@all
  end

  def self.create(name)
    song = Song.new(name)
    song.save
    song
  end

  def self.destroy_all
    self.all.clear
  end

  def self.create_from_filename(filename)
    song = self.new_from_filename(filename)
    song.save
    song
  end

  def self.new_from_filename(filename)
    info = filename.split(" - ")
    song = Song.find_or_create_by_name(info[1])
    song.artist = Artist.find_or_create_by_name(info[0])
    song.genre = Genre.find_or_create_by_name(info[2].gsub(".mp3", ""))
    song
  end

end
