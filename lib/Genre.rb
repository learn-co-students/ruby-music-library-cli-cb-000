class Genre
  extend Concerns::Findable

  attr_accessor :name, :songs
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
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

  def self.create(name)
    genre = Genre.new(name)
    genre.save
    genre
  end

#  def add_song(song)
#    if song.genre == nil
#      song.genre = self
#    end
#    unless self.songs.include?(song)
#      self.songs << song
#    end
#  end

  def artists
#    self.songs.collect { |s| s.artist }.uniq
#    @songs.collect { |s| s.artist }.uniq
    songs.collect { |s| s.artist }.uniq
  end

end
