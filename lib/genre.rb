class Genre
  extend Concerns::Findable
  attr_accessor :name, :songs
  @@all = []

  def initialize (name)
    @name = name
    @songs = []
  end

  def artists
    self.songs.collect {|s| s.artist}.uniq
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

  def self.create (name)
    new(name).tap{|s| s.save}
  end

  def add_song (song)
    song.genre = self unless song.genre == self
    @songs << song unless @songs.include?(song)
  end

  def to_s
    self.name
  end
end
