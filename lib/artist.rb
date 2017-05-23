class Artist
  extend Concerns::ClassMethods
  include Concerns::InstanceMethods

  attr_accessor :name, :songs

  @@all =  []

  def self.all
    @@all
  end

  def initialize (name)
    @name = name
    @songs = []
  end

  def add_song (song)
    @songs << song unless @songs.include?(song)
    song.artist = (self) unless song.artist == self
  end

  def genres
    @songs.map{|song| song.genre}.uniq
  end


end
