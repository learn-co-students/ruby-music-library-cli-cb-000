class Artist
  extend Concerns::Findable
  include Comparable

  attr_accessor :name
  attr_reader   :songs
  @@all = []

  def initialize(name)
    self.name = name
    @songs = []
  end

  def <=>(other)
    self.name <=> other.name
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
    Artist.new(name).tap { |artist| artist.save }
  end

  def add_song(song)
    song.artist = self if song.artist.nil?
    self.songs << song unless self.songs.map do |song|
      song.name
    end.include?(song.name)
  end

  def genres
    self.songs.map { |song| song.genre }.uniq
  end
end
