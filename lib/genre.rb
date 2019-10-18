class Genre

  extend Concerns::AllClassMethods
  extend Concerns::Findable
  include Concerns::AllInstanceMethods

  attr_accessor :name
  attr_reader :songs

  @@genres = []

  def initialize(name)
    @name = name
    @songs = []
  end

  #need to link @@genres to the @@all we call in Concerns
  def self.all
    @@genres
  end

  def self.create(name)
    self.new(name).tap{|a| a.save}
  end

  #returns unique artists of all songs in the genre (through songs)
  def artists
    @songs.collect{|song| song.artist}.uniq
  end

end
