class Genre
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

  def artists
    self.songs.collect {|x| x.artist}.uniq
  end

  def self.print_all
    self.all.each {|g| puts "#{g.name}"}
  end
end
