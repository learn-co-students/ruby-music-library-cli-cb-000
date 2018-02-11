class Song
  extend Concerns::Findable

  attr_accessor :name
  attr_reader :artist, :genre

  @@all = []

  def self.all
    @@all
  end

  # can be invoked with an optional 'artist' property (song belongs to artist)
  # can be invoked with an optional 'genre' property (song belongs to genre)
  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist # ensure that associations (song's 'artist' property) are created upon initialization
    self.genre = genre if genre # ensure that associations (song's 'genre' property) are created upon initialization
    save
  end

  # invokes Artist#add_song to add itself to the artist's collection of songs (artist has many songs)
  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  # assigns a genre to the song (song belongs to genre)
  def genre=(genre)
    @genre = genre
    # adds the song to the genre's collection of songs (genre has many songs)
    # does not add the song to the genre's collection of songs if it already exists therein
    @genre.songs << self unless genre.songs.include? self
  end

  def save
    @@all << self
  end

  def self.create(name)
    # create new object with name --> call save method on object --> return object
    new(name).tap { |x| x.save }
  end

  def self.destroy_all
    @@all.clear
  end

  def self.new_from_filename(filename)
    parts = filename.split(" - ")
    artist_name, song_name, genre_name = parts[0], parts[1], parts[2].gsub(".mp3", "")

    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre_name)

    new(song_name, artist, genre)
  end

  def self.create_from_filename(filename)
    new_from_filename(filename).tap{ |s| s.save }
  end

end
