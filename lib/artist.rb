require_relative '../config/environment.rb'
class Artist
  extend Concerns::Findable
  attr_accessor :name, :songs
  @@all=[]
  def initialize(name)
    @name=name
    @songs = []
  end
  def self.create(name)
    Artist.new(name).tap{|s|s.save}
  end
  def save
    @@all << self
  end
  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end
  def add_song(song)
    if !(@songs.include?(song))
      @songs << song
      song.artist = self
    end
  end
  # def find_or_create_by_name(name)
  #   result = @@all.detect{|s|s.name==name}
  #   result ? result : Artist.new(name)
  # end

  def genres
    @songs.collect{|s|s.genre}.uniq
  end

end
