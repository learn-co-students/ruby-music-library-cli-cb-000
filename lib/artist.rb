class Artist

  extend Concerns::Findable

  attr_accessor :name, :songs
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def genres
    genres = []
    self.songs.each do |hees|
      genres << hees.genre unless genres.include? hees.genre
    end
    return genres
  end

  def self.all
    @@all
  end

  def self.count
    @@all.size
  end

  def self.destroy_all
    @@all.clear
  end

  def save
    @@all << self
  end

  def self.create(artist)
    created_artist = self.new(artist)
    created_artist.save
    created_artist
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

# Teacher Solution

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
#   def self.all
#     @@all
#   end
#
#   def self.destroy_all
#     all.clear
#   end
#
#   def save
#     self.class.all << self
#   end
#
#   def self.create(name)
#     artist = new(name)
#     artist.save
#     artist
#
#     # Or, as a one-liner:
#     # new(name).tap{ |a| a.save }
#   end
#
#   def add_song(song)
#     song.artist = self unless song.artist
#     songs << song unless songs.include?(song)
#   end
#
#   def genres
#     songs.collect{ |s| s.genre }.uniq
#   end
# end
