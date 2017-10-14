class Song

  attr_accessor :name
  attr_reader :artist, :genre

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.add_song(self)
  end

  def self.all
    return @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def save
    self.class.all << self #unless @@all.include?(self)
  end

  def self.create(name)
    new_item = new(name)
    new_item.save
    new_item
  end

  def self.new_from_filename(filename)
    shortname = filename.chomp(".mp3")
    data = shortname.split(" - ")
    check = find_by_name(data[1])
    if check == nil
    n_artist = Artist.find_or_create_by_name(data[0])
    n_genre = Genre.find_or_create_by_name(data[2])
    new_item = new(data[1],n_artist,n_genre)
    new_item
  else
    check
  end

  end

  def self.create_from_filename(filename)
    new_item = new_from_filename(filename)
    new_item.save
    new_item
  end


  def self.find_by_name(name)
    all.detect{ |o| o.name == name }
  end

  def self.find_or_create_by_name(name)
    find_by_name(name) || create(name)
  end

end
