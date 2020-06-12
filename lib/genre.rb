require_relative '../config/environment.rb'

class Genre
  
  extend Concerns::Findable

  
  @@all = []
  
  attr_accessor :name, :songs
  
  def initialize(name)
    @name = name 
    @songs = []
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
      object = self.new(name)
    @@all << object
    object
  end
  
  def artists
    result = @songs.map do |song|
      song.artist
    end
    
    result.uniq
  end
  
  
end