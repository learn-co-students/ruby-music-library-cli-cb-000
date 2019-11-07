class Song
  attr_accessor :name, :genre
  attr_reader:artist
  @@all = []

  def self.all
    @@all
  end

  def initialize(name = nil, artist = nil, genre = nil)
    @name = name
    self.artist=(artist)
    self.genre=(genre)
  end

  def save
    @@all << self
  end

  def self.destroy_all
    all.clear
  end

  def self.create(name)
    # song = Song.new
    # song.name = name
    # song.save
    # song
    new.tap {|song| song.name = name; song.save}
  end

  def artist=(artist)
    if artist.class == Artist
      @artist = artist
      artist.add_song(self)
    end
  end

  def genre=(genre)
    if genre.class == Genre
      @genre = genre
      genre.songs << self unless genre.songs.include?(self)
    end
  end

  def self.find_by_name(name)
    all.detect {|song| song.name == name}
  end

  def self.find_or_create_by_name(name)
    find_by_name(name) || create(name)
  end

  def self.new_from_filename(filename)
    info = filename.split(" - ")
    artist = Artist.find_or_create_by_name(info[0])
    genre = Genre.find_or_create_by_name(info[2].gsub(".mp3", ""))

    new(info[1], artist, genre) unless find_by_name(info[1])
  end

  def self.create_from_filename(filename)
    # song = Song.new_from_filename(filename)
    # song.save
    # song
    new_from_filename(filename).tap {|song| song.save}
  end
end
