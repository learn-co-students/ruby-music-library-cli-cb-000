class Song
attr_accessor :name, :artist, :genre


@@all=[]

  def initialize(name, artist = nil, genre = nil)
  @name = name
  self.artist=(artist) if artist
  self.genre=(genre) if genre
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
    song = self.new(name)
    song.save
    song
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.songs << self if !genre.songs.include?(self)
  end


  def self.find_by_name(name)
    @@all.find{|song| song.name == name}
  end

  def self.find_or_create_by_name(name)
    find_by_name(name)? find_by_name(name):create(name)
  end

  def self.new_from_filename(file)
    song = file.gsub(".mp3", "").split(" - ")
    name = song[1]
    artist = Artist.find_or_create_by_name(song[0])
    genre = Genre.find_or_create_by_name(song[2])
    new_song = Song.new(name, artist, genre)
  end

  def self.create_from_filename(file)
    @@all << self.new_from_filename(file)
  end

end
