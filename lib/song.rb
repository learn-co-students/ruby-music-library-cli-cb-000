class Song
  attr_accessor :name, :artist, :genre

  @@all = []

  def initialize(name, artist = nil, genre = nil)

    @name = name
    self.artist = artist if artist #calls setter method only in cases where artist is set
    self.genre = genre if genre
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
    song = Song.new(name)
    song.save
    song
  end

  def artist
    @artist
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)

  end

  def genre
    @genre
  end

  def genre=(genre)
    genre.songs << self unless genre.songs.include? self
    @genre = genre
  end

  def self.find_by_name(name)
    @@all.detect{|song| song.name == name }

  end

  def self.find_or_create_by_name(name)
    song = self.find_by_name(name)
      if song != nil
        song
      else
        Song.create(name)
      end
    end


  def self.new_from_filename(filename)
    artist = Artist.find_or_create_by_name(filename.split(" - ")[0])
    genre = Genre.find_or_create_by_name(filename.split(" - ")[2].chomp(".mp3"))
    song = self.new(filename.split(" - ")[1], artist, genre)

  end

  def self.create_from_filename(filename)
    song = self.new_from_filename(filename)
    song.save
  end



end
