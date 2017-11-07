require "pry"

class Song
  extend Concerns::Findable
  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist=(artist) if artist != nil
    self.genre=(genre) if genre != nil
    #binding.pry
  end

  attr_accessor :name, :artist, :genre

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
    #binding.pry
  end


  def genre=(genre)
    @genre = genre
    genre.add_song(self)
  end

  def self.all
    @@all
  end

  def save
    self.class.all << self
  end

  def self.create(name)
      self.all << self.new(name)
      self.all.last
  end

#  def self.find_or_create_by_name(name)
#    self.find_by_name(name) || self.create(name)
#  end
#
#  def self.new_from_filename(file)
#    info = file.match(/(.*) - (.*)\.mp3/)
#    s = new_by_name(info[2])
#    s.artist_name = info[1]
#    #binding.pry
#    s
#  end
#
#  def self.create_from_filename(file)
#    info = file.match(/(.*) - (.*)\.mp3/)
#    s = create_by_name(info[2])
#    s.artist_name = info[1]
#    #binding.pry
#    s
#  end

  def self.destroy_all
     self.all.clear
  end

  def self.new_from_filename(filename)
    name = filename.sub(/\.mp3*/,"").split(" - ")
    #binding.pry
    song = self.find_or_new_by_name( name[1] )
    Artist.find_or_create_by_name( name[0] ).add_song(song)
    Genre.find_or_create_by_name( name[2] ).add_song(song)
    song
  end

  def self.create_from_filename(filename)
    song = self.new_from_filename(filename)
    song.save
  end

end
