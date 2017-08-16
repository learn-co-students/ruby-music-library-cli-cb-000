class Song
  extend Concerns::Findable

  attr_accessor :name
  attr_reader :artist, :genre

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.genre = genre if genre.class == Genre
    artist.add_song(self) if artist.class == Artist
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

  def self.create(name, genre = nil)
    song = self.new(name, genre)
    song.save
    song
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre unless @genre == genre
    (genre.songs << self) unless genre.songs.any? { |s| s == self }
  end

  # def self.new_from_filename(filename)
  #   filename = filename.split(" - ")
  #   name = filename[1]
  #   filename[2].slice!(".mp3")
  #   genre = Genre.find_or_create_by_name(filename[2])
  #   artist = Artist.find_or_create_by_name(filename[0])
  #
  #
  #   if find_by_name(name)
  #     find_by_name(name)
  #   else
  #     new_song = self.new(name, artist, genre)
  #   end
  # end

  def self.new_from_filename(filename)
    filename = filename.split(" - ")

    artist = Artist.find_or_create_by_name(filename[0])
    name = filename[1]
    filename[2].slice!(".mp3")
    genre = Genre.find_or_create_by_name(filename[2])

    find_by_name(name) ? find_by_name(name) : self.new(name, artist, genre)
  end

  def self.create_from_filename(filename)
    song = new_from_filename(filename)
    song.save
  end

end
