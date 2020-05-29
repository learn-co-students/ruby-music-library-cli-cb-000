class Song
  attr_accessor :name, :artist, :genre
  @@all = []

  def initialize(name, artist=nil, genre=nil)
    @name = name
    self.artist = artist if !artist.nil?
    self.genre = genre if !genre.nil?
    @@all << self
  end

  def self.all
    @@all.uniq
  end

  def self.destroy_all
    @@all = []
  end

  def save
    @@all << self
  end

  def self.create(name)
    new_song = Song.new(name)
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

  def self.create_by_name(name)
    create(name)
  end

  def self.find_or_create_by_name(name)
    found = find_by_name(name)
    if found != nil
    then
      return found
    else
      create_by_name(name)
    end
  end

  def self.find_by_name(name)
    self.all.find{|song| song.name == name}
  end

  def self.new_from_filename(filename)
    artist_s, name_s, genre_s = filename.gsub(".mp3", "").split(" - ")
    song = find_or_create_by_name(name_s.strip)
    song.artist = Artist.find_or_create_by_name(artist_s.strip)
    song.genre = Genre.find_or_create_by_name(genre_s.strip)
    song
  end

  def self.create_from_filename(filename)
    new_from_filename(filename).save
  end

end
