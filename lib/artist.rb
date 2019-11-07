class Artist
  extend Concerns::Findable

  attr_accessor :name
  @@all = []

  def self.all
    @@all
  end

  def initialize(name = nil)
    @name = name
    @songs = []
  end

  def songs
    @songs
  end

  def genres
    array = []
    self.songs.each do |song|
      array << song.genre
    end
    array.uniq
  end

  def save
    @@all << self
  end

  def self.destroy_all
    all.clear
  end

  def self.create(name)
    new.tap {|artist| artist.name = name; artist.save}
  end

  def add_song(song)
    self.songs << song unless self.songs.include?(song)
    song.artist = self unless song.artist
  end
end
