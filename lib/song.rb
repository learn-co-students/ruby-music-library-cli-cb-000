class Song
  attr_accessor :name
  attr_reader :artist, :genre
  extend Concerns::Findable
  @@all = []
  def initialize(name, artist = nil,genre = nil)
    @name = name
    if artist != nil
      self.artist = artist
    end
    if genre != nil
      self.genre = genre
    end
  end
  def artist=(artist)
    @artist = artist
    @artist.add_song(self)
  end
  def genre=(genre)
    @genre = genre
    if @genre.songs.detect {|song| song.name == self.name} == nil
      @genre.songs << self
    end
  end
  def self.all
    @@all
  end
  def self.destroy_all
    self.all.clear
  end
  def save
    @@all << self
  end
  def self.create(name)
    song = Song.new(name)
    @@all << song
    song
  end
  def self.new_from_filename(name)
    split_array = name.split(" - ")
    song = self.find_or_create_by_name(split_array[1])
    song.artist = Artist.find_or_create_by_name(split_array[0])
    song.artist.add_song(song)
    song.genre = Genre.find_or_create_by_name(split_array[2].sub! '.mp3','')
    song
  end
  def self.create_from_filename(filename)
    song = Song.new_from_filename(filename)
    @@all << song
    song
  end

end 
