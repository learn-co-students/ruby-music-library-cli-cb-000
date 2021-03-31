class Artist
  extend Concerns::Findable
  attr_accessor :name , :songs
  @@all = []
  def self.all
    @@all
  end
  def self.destroy_all
    @@all = []
  end
  def initialize(name)
    @name = name
    @songs = []
  end
  def save
    @@all << self
  end
  def self.create(name)
    artist = self.new(name)
    artist.save
    artist
  end
  def add_song(track)
    if @songs.detect {|song| song == track} == nil
      @songs << track
    end
    if !track.artist
      track.artist = self
    end
  end
  def genres
    value = @songs.collect do |song|
      song.genre
    end
    value.uniq
  end

end
