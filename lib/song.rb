require_relative '../config/environment.rb'

class Song
  
  extend Concerns::Findable

  
  @@all = []
  
  attr_accessor :name
  attr_reader :artist, :genre
  
  def initialize(name, artist = nil, genre = nil)
    @name = name 
    self.artist=(artist) if artist
    @genre = genre
    self.genre=(genre) if genre
    
  end
  
  def self.new_from_filename(file)
    artist, song, genre = file.split(" - ")
  
    
    new_artist = Artist.find_or_create_by_name(artist)
    
    
    modified_genre = genre.split(".")
    new_genre = Genre.find_or_create_by_name(modified_genre[0])
    new(song, new_artist, new_genre)
  end
  
  def self.create_from_filename(file)
    @@all << self.new_from_filename(file)
  end
  
  
  # def self.find_by_name(name)
  #   @@all.detect do |song|
  #     return song if song.name == name
  #   end
  # end
  
  # def self.find_or_create_by_name(name)
  #   object = self.find_by_name(name)
  #   return object if object
    
  #   new_object = self.create(name)
  #   return new_object
  # end
  
  
  def artist=(artist)
    @artist = artist
    artist.add_song(self) if artist.songs.include?(self) == false
  end
  
  def genre=(genre)
    @genre = genre
    genre.songs << self if genre.songs.include?(self) == false
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
end