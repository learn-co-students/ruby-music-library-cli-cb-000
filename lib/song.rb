class Song
  attr_accessor :name
  attr_reader :artist

  @@all=[]

  def initialize(name, artist = nil)
    @name = name
    @artist = artist
    # @artist = artist(artist)
    # self.artist = artist(artist)

    # @artist = artist(artist)

    # if !artist.nil?
  # doesnt make sense
    # artist(artist)
  # end

  end

# investigate this error in ts.rb
# wrong number of arguments (given 1, expected 0)
  def artist=(artist)
    # LFFFF
    # this should assign @artist to the artist obj if it's provided.
    # dont see how that's not happening here?
  # if !@artist.nil?

  # artist
  @artist = artist
  artist.add_song(self)
  # end
end

  def self.all
    @@all
  end

  def save
    @@all << self
  end

  def self.create(name)
    obj = self.new(name)
    # should save this specific instance
    obj.save
    obj
  end

  def self.destroy_all
    self.all.clear
  end

end
