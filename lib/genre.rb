class Genre
  extend Concerns::ClassMethods
  extend Concerns::Findable
  include Concerns::InstanceMethods

  attr_accessor :name, :songs

  @@all = []

  def self.all
    @@all
  end

  def initialize (name)
    @name = name
    @songs = []
  end

  def artists
    @songs.map{|song| song.artist}.uniq
  end

end
