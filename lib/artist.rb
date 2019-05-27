class Artist
  extend Concerns::Findable
  extend Concerns::Memorable::ClassMethods
  include Concerns::Memorable::InstanceMethods

  attr_accessor :name
  attr_reader :songs

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.all # Class Reader
    #self.all
    @@all
  end

  # Moved to Memorable
  #def save
  #  @@all << self
  #end
  #
  #def self.destroy_all
  #  #self.all.clear
  #  @@all.clear
  #end
  #
  #def self.create(name)
  #  @name = name
  #  artist = self.new(name)
  #  artist.save
  #  artist
  #end

  def add_song(song)
    @songs << song unless songs.include?(song)
    song.artist = self unless song.artist == self
  end

  def genres
    # It looks like a reader but its more complicated.
    # Creates a has many through
    # Artist goes through songs and collects for each song, the genre for that song.
    @songs.collect{|song| song.genre}.uniq
  end

end
