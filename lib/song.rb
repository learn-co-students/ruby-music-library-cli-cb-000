class Song
  attr_accessor :name
  attr_reader :artist, :genre

  @@all = []

  def initialize(name, artist=nil, genre=nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end

  def self.create(name)
    song = Song.new(name, artist=nil, genre=nil)
    song.save
    song
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all = []
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
    genre.songs << self if !genre.songs.include?(self)
  end

  def self.find_by_name(title)
    all.find { |song| song.name == title }
  end

  def self.find_or_create_by_name(title, artist=nil, genre=nil)
    if self.find_by_name(title)
      self.find_by_name(title)
    else
      Song.create(title)
    end
  end

  def self.new_from_filename(filename)
    filename = filename[0..-5]
    file_artist, file_song, file_genre = filename.split(" - ")
    artist = Artist.find_or_create_by_name(file_artist)
    genre = Genre.find_or_create_by_name(file_genre)
    song = Song.new(file_song)
    song.artist = artist
    song.genre = genre
    song
  end

  def self.create_from_filename(filename)
    song = self.new_from_filename(filename)
    all << song
  end
end
