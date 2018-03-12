class Song
  attr_accessor :name
  attr_reader :artist

  @@all=[]

  def initialize(name, artist = nil)
    @name = name

# doesnt make sense
    if !artist.nil?
      # use proper setter syntax!!!
      self.artist = artist
    end

  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
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
