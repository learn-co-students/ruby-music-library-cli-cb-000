require_relative '../config/environment.rb'
class Artist
  
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
  
  def add_song(song)
    song.artist = self if song.artist == nil
    @songs << song if @songs.include?(song) == false
  end
  
  def genres
    result = @songs.map do |song|
      song.genre
    end
    
    result.uniq
  end
  
  
  
  
  
  
  
  
end