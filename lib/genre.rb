class Genre
  extend Concerns::Findable
  
  attr_accessor :name
  attr_reader :songs

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.destroy_all
    self.all.clear
  end

  def save
    self.class.all << self
  end

  def self.create(name)
    new(name).tap{|s| s.save}
  end

  def self.all
    @@all
  end

  def add_song(song)
    @songs << song unless @songs.detect { |s| s.name == song.name }
    song.genre = self unless song.genre != nil
  end

  def artists
    self.songs.collect { |song| song.artist }.uniq
  end
end
