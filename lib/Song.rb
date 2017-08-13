class Song

  attr_accessor :name

  @@all = []

  #def initialize(name="no_name", artist="no_artist", genre="no_genre")
  def initialize(name=nil, artist=nil, genre=nil)
    @name = name
    self.artist = artist if artist
    #@artist = artist
    self.genre = genre if genre
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

  def self.create(name=nil)
    created = new(name)
    created.save
    created
  end

  def artist
    @artist
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre
    @genre
  end

  def genre=(genre)
    #it sets the song's @artist property and adds the song to the artist's collection of songs
    @genre = genre
    genre.songs << self unless genre.songs.include?(self)
  end

  def self.find_by_name(name)
    @@all.detect { |s| s.name == name }
  end

  def self.find_or_create_by_name(name)
    if self.find_by_name(name).nil?
      self.create(name)
    else
      self.find_by_name(name)
    end
  end

  def self.new_from_filename(filename)
    elements = filename.split(" - ")
    song_title = elements[1]
    artist_name = elements[0]
    artist = Artist.find_or_create_by_name(artist_name)
    genre_name = elements[2].chomp(".mp3")
    genre = Genre.find_or_create_by_name(genre_name)
    new_song = Song.new(song_title, artist, genre)
    new_song
  end

  def self.create_from_filename(filename)
    new_song = Song.new_from_filename(filename)
    new_song.save
    new_song
  end

end
