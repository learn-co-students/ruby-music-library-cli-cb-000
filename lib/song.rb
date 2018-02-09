class Song
  attr_accessor :name
  attr_reader   :artist, :genre
  @@all = []

  def initialize(name, artist = nil, genre = nil)
    self.name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all = []
  end

  def save
    @@all << self
  end

  def self.create(name)
    Song.new(name).tap { |song| song.save }
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.add_song(self) unless genre.songs.map do |song|
      song.name
    end.include?(self.name)
  end

  def self.find_by_name(name)
    self.all.select { |song| song.name == name }[0]
  end
end
