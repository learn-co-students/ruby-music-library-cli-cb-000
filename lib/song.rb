class Song
  attr_accessor :name
  # we have custom setters for below
  attr_reader :artist, :genre

  @@all=[]

  def initialize(name, artist = nil, genre= nil)
    @name = name
    # @genre = genre

    if !artist.nil?
      # use proper setter syntax!!!
      self.artist = artist
    end
    if !genre.nil?
      # use proper setter syntax!!!
      self.genre = genre
    end

  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.add_song(self)
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
