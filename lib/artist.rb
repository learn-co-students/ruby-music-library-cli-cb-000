class Artist
  extend Concerns::Findable
  extend Memorable::ClassMethods
  include Memorable::InstanceMethods

  attr_accessor :name
  attr_reader :songs
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.all
    @@all
  end

  def add_song(song)
    self.songs << song if !self.songs.any? {|x| x == song}
    song.artist = self if song.artist != self
  end

  def genres
    self.songs.collect {|x| x.genre}.uniq
  end

  def self.print_all
    self.all.each {|a| puts "#{a.name}"}
  end

end
