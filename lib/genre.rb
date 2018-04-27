class Genre

  attr_accessor :name, :song
  extend Concerns::Findable

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
    @@all.clear
  end

  def self.create(name)
    genre = self.new(name)
    genre.save
    genre
  end

  def add_song(song)
    song.genre = self unless song.genre
    self.songs << song unless self.songs.include?(song)
  end

  def artists
    self.songs.collect {|song| song.artist if song.artist}.uniq
  end

  def songs
    @songs
  end

end
