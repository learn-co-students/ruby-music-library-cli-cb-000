# Song class
class Song
  extend Concerns::Findable

  @@all = []
  attr_accessor :name
  attr_reader :artist, :genre

  #-------- Initialize --------#
  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end

  # Cutom setters enable relationships among objects

  def artist=(name)
    @artist = name
    artist.add_song(self)
  end

  def genre=(name)
    @genre = name
    name.songs << self unless @genre.songs.include?(self)
  end

  #-------- Find --------#

  def self.find_by_name(name)
    all.detect { |song| song.name == name }
  end

  def self.find_or_create_by_name(name)
    find_by_name(name) || create(name)
  end

  #-------- Memorable --------#

  def self.all
    @@all
  end

  def self.destroy_all
    all.clear
  end

  def save
    self.class.all << self
  end

  def self.create(name)
    new(name).tap(&:save)
  end

  #-------- Files --------#

  def self.new_from_filename(file)
    split = file.split(' - ')
    artist_name = split[0]
    song_name = split[1]
    genre_name = File.basename(split[2], '.mp3')

    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre_name)

    new(song_name, artist, genre) unless find_by_name(name)
  end

  def self.create_from_filename(file)
    new_from_filename(file).save
  end
end
