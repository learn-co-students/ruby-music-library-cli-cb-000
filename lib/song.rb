class Song

  attr_accessor :name
  attr_reader :artist, :genre

  @@all = []

  def self.all
    @@all
  end

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist
    self.genre = genre
  end

  def artist=(artist)
    return unless artist.is_a?(Artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    return unless genre.is_a?(Genre)
    @genre = genre
    genre.songs << self unless find_song(self, genre)
  end

  def save
    self.class.all << self
  end

  def self.create(name)
    song = Song.new(name)
    song.save
    song
  end

  def self.destroy_all
    all.clear
  end

  def find_song(song, genre)
    genre.songs.find { |existing_song| existing_song.name == song.name }
  end

  def self.find_by_name(name)
    all.detect{ |s| s.name == name }
  end

  def self.find_or_create_by_name(name)
    find_by_name(name) || create(name)
  end

  def self.new_from_filename(filename)
    (artist, name, genre) = File.basename(filename, '.*').split(' - ')
    # puts "Name: #{name}, Artist: #{artist}, Genre: #{genre}"
    g = Genre.find_or_create_by_name(genre)
    a = Artist.find_or_create_by_name(artist)
    song = Song.find_or_create_by_name(name)

    # binding.pry
    # puts "Song: #{song}, Artist: #{a}, Genre: #{g}"
    song.genre = g
    song.artist = a
    song
  end

  def self.create_from_filename(filename)
    song = Song.new_from_filename(filename)
    song.save
  end

end