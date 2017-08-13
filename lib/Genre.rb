class Genre

  extend Concerns::Findable

  attr_accessor :name, :songs
  @@all = []

  def initialize(name=nil)
    @name = name
    @songs = []
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def save
    @@all << self
  end

  def self.create(name=no_name)
    created = new(name)
    created.save
    created
  end

  def artists
    self.songs.collect{|s| s.artist}.uniq
  end

end
