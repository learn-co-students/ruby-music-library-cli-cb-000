class Song
  extend Concerns::Findable
  attr_accessor :name, :genre, :artist

  @@all = []

  def initialize(name, artist=nil, genre=nil)
    @name = name
    @artist = artist
    @genre = genre
    if artist
      artist.add_song(self)
    end
    if genre
      genre.add_song(self)
    end
  end

  def self.all
    @@all
  end

  def self.destroy_all
    self.all.clear
  end

  def save
    if !Song.all.include?(self)
      Song.all << self
    end
    self
  end

  def self.create(name)
    song = Song.new(name)
    song.save
  end

  def artist=(new_artist)
    @artist = new_artist
    new_artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.add_song(self)
  end

  def self.new_from_filename(filename)
    artist_name, title, genre_name = filename.split('.').first.split(' - ')
    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre_name)
    song = Song.new(title)
    artist.add_song(song)
    genre.add_song(song)
    song
  end

  def self.create_from_filename(filename)
    song = new_from_filename(filename)
    song.save
  end

  def display
    "#{self.artist.name} - #{self.name} - #{self.genre.name}"
  end

end
