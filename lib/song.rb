class Song
  extend Concerns::Findable
  attr_accessor :name
  attr_reader :artist, :genre
  @@all = []

  def initialize(name, artist=nil, genre=nil)
    @name = name
    if artist != nil
      self.artist=(artist)
    end

    if genre != nil
      self.genre=(genre)
    end
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def save
    self.class.all << self
  end

  def self.create(name)
    song = self.new(name)
    @@all << song
    song
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre=genre
    genre.add_song(self)
  end

  def self.new_from_filename(name)
    name = name.chomp(".mp3")
    arr = name.split(" - ")
    if !(find_by_name(arr[1]))
      song = Song.new(arr[1])
      song.artist = Artist.find_or_create_by_name(arr[0])
      song.genre = Genre.find_or_create_by_name(arr[2])
      #song.artist.songs << song
      song
    end
  end

  def self.create_from_filename(name)
    song = self.new_from_filename(name)
    song.save
  end

  #def self.find_by_name(title)
  #  @@all.detect{|song| song.name == title}
  #end

  #def self.find_or_create_by_name(title)
  #  if self.find_by_name(title)
  #    self.find_by_name(title)
  #  else
  #    self.create(title)
  #  end
  #end

end #closes Song Class
