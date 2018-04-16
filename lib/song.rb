class Song
  attr_accessor :name
  attr_reader :artist, :genre

  # extend Concerns::Findable

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end

  def save
    @@all << self
  end

  def artist=(artist)
    @artist = artist
    # if artist != nil
      artist.add_song(self)
    # end
  end

  def genre=(genre)
    @genre = genre
    # if genre != nil
      genre.add_song(self)
    # end
  end

  def self.find_by_name(song_name)
    self.all.detect{|a| a.name == song_name}
  end

  def self.find_or_create_by_name(song_name)
    self.find_by_name(song_name) || self.create(song_name)
  end

  def self.create(name)
    new_song = self.new(name)
    new_song.save
    new_song
  end

  def self.new_from_filename(filename)
    artist_name, song_name, genre_name = filename.split(" - ")

    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre_name)

    new(song_name, artist, genre)

    # new_song = self.find_or_create_by_name(song)
    # new_song.artist = artist
    # new_song.genre = genre
    # new_song
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

end
