
# class Artist
#   extend Concerns::Findable
#
#   attr_accessor :name
#   attr_reader :songs
#
#   @@all = []
#
#   def initialize(name)
#     @name = name
#     @songs = []
#   end
#
#   def genres
#     genres = []
#     @songs.each do |song|
#       if !genres.include? song.genre
#         genres << song.genre
#       end
#     end
#     genres
#   end
#
#
#   def songs
#     @songs
#   end
#
#
#   def add_song(song)
#     if song.artist != self
#       song.artist = self
#     end
#
#     if !@songs.include? song
#       @songs << song
#     end
#   end
#
#
#   def self.all
#     @@all
#   end
#
#
#   def self.destroy_all
#     @@all.clear
#   end
#
#
#   def save
#     @@all << self
#   end
#
#
#   def self.create(name)
#     artist = self.new(name)
#     artist.save
#     artist
#   end
#
# end


class Artist
  extend Concerns::Findable

  attr_accessor :name
  attr_reader :songs

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.all
    @@all
  end

  def self.destroy_all
    all.clear
  end

  def save
    self.class.all << self
  end

  def self.create(name)
    artist = new(name)
    artist.save
    artist

    # Or, as a one-liner:
    # new(name).tap{ |a| a.save }
  end

  def add_song(song)
    song.artist = self unless song.artist
    songs << song unless songs.include?(song)
  end

  def genres
    songs.collect{ |s| s.genre }.uniq
  end
end
