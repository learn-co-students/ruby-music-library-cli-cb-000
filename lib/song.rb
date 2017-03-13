class Song
  attr_accessor :name, :genre
  attr_reader :artist

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    @artist = artist
    @genre = genre
    artist.add_song(self) unless artist == nil
    genre.add_song(self) unless genre == nil
  end

  def self.create(name, artist = nil, genre = nil)
    new(name, artist, genre).tap{|s| s.save}
  end

  def self.all
    @@all
  end

  def self.destroy_all
    self.all.clear
  end

  def save
    self.class.all << self
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
    @@all.detect { |song| song.name == name}
  end

  def self.find_or_create_by_name(name)
    self.find_by_name(name) || self.create(name)
  end

  def self.new_from_filename(file)
    name = file.split(" - ")[1]
    artist = Artist.find_or_create_by_name(file.split(" - ")[0])
    genre = Genre.find_or_create_by_name(file.split(" - ")[2].gsub(".mp3", ""))
    self.new(name, artist, genre)
  end

  def self.create_from_filename(file)
    name = file.split(" - ")[1]
    artist = Artist.find_or_create_by_name(file.split(" - ")[0])
    genre = Genre.find_or_create_by_name(file.split(" - ")[2].gsub(".mp3", ""))
    self.create(name, artist, genre)
  end
end
