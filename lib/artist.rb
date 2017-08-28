class Artist

  extend Concerns::Findable
  
  attr_accessor :name
  attr_reader :songs
  @@all = []

  def initialize name
    self.name = name
    @songs = []
  end

  def save
    @@all << self
    self
  end

  def self.create name
    Artist.new(name).save
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def add_song song
    @songs << song unless @songs.include?(song)
    song.artist = self if song.artist.nil?
  end

  def genres
    self.songs.collect(&:genre).uniq
  end

end
