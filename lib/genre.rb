class Genre
  attr_accessor :name, :songs

  @@all = []

  def self.all
    @@all
  end

  def initialize(name)
    @name = name
    @songs = [] # creates a 'songs' property set to an empty array (genre has many songs)
    save
  end

  def save
    @@all << self
  end

  def self.create(name)
    # create new object with name --> call save method on object --> return object
    new(name).tap { |x| x.save }
  end

  def self.destroy_all
    @@all.clear
  end
end