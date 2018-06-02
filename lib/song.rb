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


  def self.new_from_filename(filename)
   info = filename.split(" - ")
   artist = Artist.find_or_create_by_name(info[0])
   genre = Genre.find_or_create_by_name(info[2].gsub(".mp3", ""))

     new(info[1], artist, genre) unless find_by_name(info[1])
   end

  def self.create_from_filename(name)
    song = Song.new_from_filename(name)
    @@all << song
  end

end
