class Genre

  attr_accessor :name

  def initialize(name)
    @name = name
  end

  @@all = []

  def self.all
    @@all
  end

  def save
    @@all << self
  end

  def self.create(name)
    genre = Genre.new(name)
    genre.save
    genre
  end

  def self.destroy_all
    @@all.clear
  end
end