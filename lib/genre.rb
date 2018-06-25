class Genre

  extend Concerns::Findable

  attr_accessor :name, :songs

  @@all = []

  def initialize(name)
    @name = name
    @@all << self
    @songs = []
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
    new_song = Genre.new(name)
  end

  def add_song(song)
    song.genre = self if song.genre == nil
    self.songs << song unless self.songs.include?(song)
  end

  def artists
    self.songs.map {|i| i.artist}.uniq
  end

end
