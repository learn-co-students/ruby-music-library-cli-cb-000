class Song
  attr_accessor :name

  @@all = []

  def self.all
    @@all
  end

  def initialize
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