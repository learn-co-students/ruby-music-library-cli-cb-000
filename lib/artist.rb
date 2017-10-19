require 'pry'

class Artist
  extend Concerns::Findable
  
  attr_accessor :name, :songs
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.all # Can be abstracted into a module
    @@all
  end

  def self.destroy_all # Can be abstracted into a module
    @@all.clear
  end

  def save
    self.class.all << self
  end

  def self.create(name)
    self.new(name).tap(&:save)
  end

  # Had trouble here.
  # Original code had issues with:
    # def add_song(song)
    #   songs << song unless songs.include?(song)
    # end
  # Also see Song#artist=
    # if artist
      #   @artist = artist
      #   artist.add_song(self)
      # end
# Was failing test: expect(song.artist).to be(artist)
  def add_song(song)
    song.artist = self unless song.artist
    @songs << song unless songs.include?(song)
  end

  def genres # returns genres > eg. [punk, rock]
    songs.collect(&:genre).uniq
  end
end
