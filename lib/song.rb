class Song
  attr_accessor :name, :genre
  attr_reader :artist
  extend Concerns::SaveRelated::ClassMethods
  include Concerns::SaveRelated::InstanceMethods
  extend Concerns::Findable

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist != nil
    self.genre = genre if genre
  end

  def self.all
    @@all
  end

  def self.create(song, artist = nil, genre = nil)
    new_song = Song.new(song, artist, genre)
    new_song.save
    new_song
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.add_song(self)
  end

  def self.create_from_filename(filename)
    song = new_from_filename(filename)
    @@all << song
    song
  end

  def self.new_from_filename(filename)
    song_array = filename.chomp(".mp3").split(" - ")

    artist = Artist.find_or_create_by_name(song_array[0])
    genre = Genre.find_or_create_by_name(song_array[2])
    self.new(song_array[1], artist, genre)
  end

  def self.create_artist_title_genre(name, title, genre)
    artist = Artist.find_or_create_by_name(name)
    song = Song.new(title)
    song.genre = genre
    artist.add_song(song)
    artist
  end

  def self.print_with_index
    self.all.each_with_index { |song, index| puts "#{index+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}" }
  end

  def self.print_song(song)
    "#{song.artist.name} - #{song.name} - #{song.genre.name}"
  end

end
