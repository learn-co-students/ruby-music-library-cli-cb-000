#add requires
class Genre
  extend Concerns::Findable
  include Concerns::Sortable

  @@all = []
  attr_accessor :name, :songs

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all = []
  end

  def self.create(name)
    genre = self.new(name)
    genre.save
    genre
  end

  def save
    self.class.all << self
  end

  def add_song(song)
    song.genre = self unless song.genre
    self.songs << song unless self.songs.include?(song)
  end

  def artists
    self.songs.collect {|song| song.artist if song.artist }.uniq
  end

end
