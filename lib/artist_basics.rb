require 'pry'
class Artist

  attr_accessor :name, :songs

  extend Concerns::Findable

  @@artists = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.all
    @@artists
  end

  def save
    self.class.all << self
  end

  def self.destroy_all
    self.all.clear
  end

  def self.create(name)
    artist = self.new(name)
    artist.save
    artist
  end

  def add_song(song)
    @songs << song if @songs.none? {|e| e.name == song.name}
    song.artist = self if song.artist == nil
  end

  def genres
      self.songs.uniq {|e| e.genre.name}.map {|i| i.genre}
  end

  def self.print_artists
    arr= []
    self.all.uniq {|e| arr << "#{e.name}"}
    arr.sort
  end

end
