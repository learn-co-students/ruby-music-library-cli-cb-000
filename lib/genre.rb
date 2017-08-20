class Genre
  extend Concerns::Findable

  attr_accessor :name, :songs

  @@all = []

  def initialize(name)
    self.name = name
    self.songs = []
  end

  def add_song(song)
    if !self.songs.include?(song)
      self.songs << song
    end

    if song.genre == nil
      song.genre = self
    end
  end

  def artists
    cuck = self.songs.collect {|song| song.artist}
    cuck.uniq {|artist| artist.name}
  end

#class methods
  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create(name)
    Genre.new(name).tap do |genre|
      genre.save
    end
  end

  def save
    @@all << self
  end

end
