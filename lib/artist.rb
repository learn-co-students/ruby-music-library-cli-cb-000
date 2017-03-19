class Artist
  attr_accessor :name, :songs
  @@all = []
  extend Concerns::Findable
  def initialize name
    @name = name
    @songs = []
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create name
    Artist.new(name).tap {|s| s.save}
  end

  def save
    self.class.all << self
  end

  def add_song song
    song.artist = self unless song.artist == self
    @songs << song unless @songs.include?(song)
  end

  def genres
    @songs.collect {|song| song.genre}.uniq
  end
end
