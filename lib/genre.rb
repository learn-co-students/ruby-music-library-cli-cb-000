class Genre
  extend Concerns::Findable

  @@all = []

  attr_accessor :name

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.all
    @@all
  end

  def self.destroy_all
    all.clear
  end

  def save
    self.class.all << self
  end

  def self.create(name)
    genre = new(name)
    genre.save
    genre
  end

  def songs
    @songs
  end

  def add_song(song)
    song.genre = self unless song.genre
    songs << song unless songs.include?(song)
  end


  def artists
      songs.map{ |s| s.artist}.uniq
  end



end
