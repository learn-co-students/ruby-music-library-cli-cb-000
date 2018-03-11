class Genre
  attr_accessor :name
  @@all=[]

  def initialize(name)
    @name = name

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
