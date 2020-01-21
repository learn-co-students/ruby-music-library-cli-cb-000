class Song
  attr_accessor :name, :artist, :genre

  @@all = []

  def initialize (name, artist=nil, genre=nil)
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
    genre.songs << self if genre.songs.include?(self) == false
  end

  #________Instance___Methods___________________

  def save
    self.class.all << self
  end

  #________Class___Methods___________________

  def self.create (name)
    song= Song.new(name)
    self.all << song
    song
  end

  def self.find_by_name(name)
    self.all.detect{|song| song.name == name}
  end

  def self.find_or_create_by_name(name)
    self.all.any?{|song| song.name == name} ? self.find_by_name(name) : self.create(name)
  end

  def self.new_from_filename(filename)
    list = filename.split(' - ')
    artist = Artist.find_or_create_by_name(list[0])
    genre = Genre.find_or_create_by_name(list[2].chomp(".mp3"))
    song = self.new(list[1], artist, genre)
  end

  def self.create_from_filename(filename)
    song = self.new_from_filename(filename)
    song.save
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all = []
  end
end
