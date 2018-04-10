class Artist
  #extend Concerns::Findable::ClassMethods
  #include Concerns::Findable::InstanceMethods
  extend Concerns::Findable

  attr_accessor :name, :songs
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
    #save
  end

  def self.all
    @@all
  end

  def save
    @@all << self
  end

  def self.destroy_all
    self.all.clear
  end

  def self.create(name)
    artist = Artist.new(name)
    artist.save
    artist
  end

  def add_song(song)
    if song.artist == nil
      song.artist = self
    end
    unless self.songs.include?(song)
      self.songs << song
    end
  end

  def genres
    self.songs.collect { |song| song.genre  }.uniq
  end

end
