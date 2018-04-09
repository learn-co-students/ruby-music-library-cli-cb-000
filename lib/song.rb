require 'pry'

class Song
  extend Memorable::ClassMethods, Concerns::Findable
  include Memorable::InstanceMethods

  @@all = []
  attr_accessor :artist, :genre

  def initialize(name, artist=nil, genre=nil)
    super
    self.artist= artist if artist != nil
    self.genre= genre if genre != nil
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.songs << self unless genre.songs.include? self
  end

  def self.new_from_filename(filename)
  file_data = filename.split(" - ")
  artist = Artist.find_or_create_by_name(file_data[0])
  genre = Genre.find_or_create_by_name(file_data[2].scan(/[^\.]+/)[0])
  song = self.new(file_data[1], artist, genre) if Song.find_by_name(file_data[1]) == nil
  return song
end


def self.create_from_filename(filename)
  song = self.new_from_filename(filename)
  self.all << song unless self.all.include? song
  return song
end

end
