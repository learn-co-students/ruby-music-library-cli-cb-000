class Artist
  attr_accessor :name, :songs
  @@all = []
  extend Concerns::Findable

  def initialize(name)
    @name = name
    @songs = []
  end
  def songs
   @songs
 end

  def self.all
    @@all
  end
  def add_song(song)
    song.artist = self unless song.artist
    self.songs << song if !self.songs.include?(song)

  end
  def genres
      the_songs = songs.map do |s|
         s.genre
       end
       the_songs.uniq
  end
  def save
    @@all << self
  end

  def self.create(name)
    new_artist = self.new(name)
    new_artist.save
    new_artist
  end

  def self.destroy_all
    @@all.clear
  end

end
