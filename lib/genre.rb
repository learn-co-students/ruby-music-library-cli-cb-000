class Genre
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
      song.genre = self if song.genre == nil
    end
  end

  def artists
    self.songs.collect{|song| song.artist}.uniq
  end
end
