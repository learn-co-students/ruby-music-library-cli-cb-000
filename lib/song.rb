class Song

  # extend Concerns::Findable

  attr_accessor :name
  attr_reader :artist, :genre
  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist != nil
    self.genre = genre if genre != nil
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.songs << self unless genre.songs.include? self
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

  def self.create(name)
    created_song = self.new(name)
    created_song.save
    created_song
  end

  def self.find_by_name(name)
    @@all.detect{|song| song.name == name}
  end

  def self.find_or_create_by_name(name)
    if self.find_by_name(name) == nil
      self.create(name)
    else
      self.find_by_name(name)
    end
  end

  def self.new_from_filename(name)
    split_array = name.split(" - ")
    song = self.find_or_create_by_name(split_array[1])
    song.artist = Artist.find_or_create_by_name(split_array[0])
    song.artist.add_song(song)
    song.genre = Genre.find_or_create_by_name(split_array[2].sub! '.mp3','')
    song
  end

  def self.create_from_filename(song)
    hees = Song.new_from_filename(song)
    @@all.push(hees)
  end

end
