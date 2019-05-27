class Song
  extend Concerns::Findable
  extend Concerns::Memorable::ClassMethods
  include Concerns::Memorable::InstanceMethods

  attr_accessor :name
  attr_reader :artist, :genre

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end

  def self.all # Class Reader
    #self.all
    @@all
  end

  # Moved to Memorable
  #def save
  #  #self.class.all << self
  #  @@all << self
  #end
  #
  #def self.destroy_all
  #  #self.all.clear
  #  @@all.clear
  #end
  #
  #def self.create(name)
  #  @name = name
  #  song = self.new(name)
  #  song.save
  #  song
  #end

  def artist=(artist)
    # Assign that artist to myself
    @artist = artist

    # Creates a reciprocal belongs to
    # Tell the artist that it has a new song (self)
    artist.add_song(self)
  end

  def genre=(genre)
    # Assign that genre to myself
    @genre = genre

    # Creates a reciprocal belongs to
    # Tell the genre that it has a new song (self)
    genre.songs << self unless genre.songs.include?(self)
  end

  # Moved to Findable
  #def self.find_by_name(name) # Class finder
  #  @@all.detect { |song| song.name == name}
  #end
  #
  #def self.find_or_create_by_name(name)
  #  self.find_by_name(name) ? self.find_by_name(name) : self.create(name)
  #end

  def self.new_from_filename(filename)
    data = filename.split(" - ")
    genre_name=data[2].split(".")[0]
    #binding.pry
    # create the song(name, artist, genre)
    song = self.new(data[1], Artist.find_or_create_by_name(data[0]), Genre.find_or_create_by_name(genre_name))
    song
  end

  def self.create_from_filename(filename)
    song = self.new_from_filename(filename)
    song.save
    song
  end

end
