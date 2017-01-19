# require 'pry'
class Song
  extend Concerns::Findable
  include Concerns::Savable::InstanceMethods
  extend Concerns::Savable::ClassMethods

  attr_accessor :name, :artist, :genre
  @@all = []

  #Hook method
  def initialize(name, artist = nil, genre = nil)
    @name = name
    #self.artist = artist if artist
    #similar to @artist = artist if artist is not nil
    self.artist = artist if artist != nil
    self.genre = genre if genre
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.songs << self unless genre.songs.include?(self)
  end

  # Class Constructor:
  def self.create(name, artist = nil, genre = nil)
    self.new(name, artist, genre).tap{|o| o.save}
  end
  # Using .tap is prefered for readablity
  # self.new and new without self both work
  # Alternate:
  # def self.create(name, artist=nil, genre=nil)
	#   object = self.new(name, artist, genre)
  # 	object.save
  # 	object
  # end
  # all classes should implement a custom constructor .create that instantiates an instance using .new but also evokes #save on that instance, forcing it to persist immediately.

  def self.all #Class Getter method. Can't modularize this.
    @@all
  end

  #Class Constructor methods:
  def self.new_from_filename(filename)
    parts = filename.split(" - ")
    artist_name, song_name, genre_name = parts[0], parts[1], parts[2].gsub(".mp3", "")
    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre_name)
    self.new(song_name, artist, genre)
  end

  def self.create_from_filename(filename)
    parts = filename.split(" - ")
    artist_name = parts[0]
    song_name = parts[1]
    genre_name = parts[2].gsub(".mp3", "")
        #class method takes in a filename and splits its parts at the "-" into an array of parts. array[0] is artist_name, etc. Note arry[2] uses gsub to remove .mp3
    artist = Artist.find_or_create_by_name(artist_name)
        #var artist = calls the Artist class method passing the argument
    genre = Genre.find_or_create_by_name(genre_name)
        #var genre does the same in the Genre class
    self.create(song_name, artist, genre)
  end

  def to_s
    "#{self.artist.name} - #{self.name} - #{self.genre.name}"
    # returns a string in the above format
  end
end
