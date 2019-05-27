class Genre
  extend Concerns::Findable
  extend Concerns::Memorable::ClassMethods
  include Concerns::Memorable::InstanceMethods

  attr_accessor :name
  attr_reader :songs # has many songs

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
  #  genre = self.new(name)
  #  genre.save
  #  genre
  #end

  def artists
    # It looks like a reader but its more complicated.
    # Creates a has many through
    # Genre goes through songs and collects for each song, the artist for that song.
    @songs.collect{|song| song.artist}.uniq
  end

end
