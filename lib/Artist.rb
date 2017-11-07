class Artist
  attr_accessor :name, :songs
  extend Concerns::Findable
  @@all = []
  def initialize(name)
    @name = name
    @songs = []
  end
  def genres
    @songs.collect do |song|
      song.genre
    end.uniq
  end
  def self.all
    @@all
  end
  def self.destroy_all
    self.all.clear
  end
  def save
    @@all << self
  end
  def self.create(name)
    artist = Artist.new(name)
    @@all << artist
    artist
  end
  def add_song(song)
    if @songs.detect {|songNew| songNew.name == song.name} == nil
      @songs << song
      if song.artist == nil
        song.artist = self
      end
    end
  end
end
