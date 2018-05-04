class Song
  attr_accessor :name
  
  def initialize(name)
    @name = name
    @@all = []
  end
  
  def self.all
    return @@all
  end
  
  def self.destroy_all
    @@all = []
  end
end