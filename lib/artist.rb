class Artist
  extend Concerns::Findable, Memorable::ClassMethods
  include Memorable::InstanceMethods

  attr_accessor :name
  @@all = []

  def self.all
    @@all
  end

  def add_song(song)
    if @songs.include?(song) == false
      @songs << song
      song.artist = self if song.artist == nil
    end
  end

  def genres
    self.songs.collect{|song| song.genre}.uniq
  end
end
