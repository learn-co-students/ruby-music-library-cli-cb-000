class Song

  extend Concerns::Findable

  @@all=[]

  attr_accessor :name
  attr_reader :artist, :genre

  def initialize(name, artist=nil, genre=nil)
    @name=name
    @artist=artist
    @artist.add_song(self) if @artist
    @genre=genre
    @genre.songs << self if @genre
  end

  def self.all
    @@all
  end

  def save
    @@all << self
  end

  def self.destroy_all
    self.all.clear
  end

  def self.create(song_name)
    # song=self.new(song_name)
    # song.save
    # song

    self.new(song_name).tap {|song| song.save}
  end

  def artist=(artist)
    if !self.artist
      @artist=artist
      artist.add_song(self) if !artist.songs.include?(self)
    end
  end

  def genre=(genre)
    if !self.genre
      @genre=genre
      genre.songs << self if !genre.songs.include?(self)
    end
  end

  def self.new_from_filename(filename)
    song=self.new(filename.split(/[-.]/)[1].strip)
    artist=Artist.find_or_create_by_name(filename.split(/[-.]/)[0].strip)
    genre=Genre.find_or_create_by_name(filename.split(/[-.]/)[2].strip)
    song.genre=genre
    song.artist=artist
    song
  end

  def self.create_from_filename(filename)
    song=self.create(filename.split(" - ")[1].strip)
    artist=Artist.find_or_create_by_name(filename.split(" - ")[0].strip)
    genre=Genre.find_or_create_by_name(filename.split(" - ")[2].split(".")[0])
    song.genre=genre
    song.artist=artist
    song
  end

  def print
    "#{Song.all.index(self)+1}. #{self.artist.name} - #{self.name} - #{self.genre.name}"
  end

end
