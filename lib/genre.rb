class Genre

  extend Concerns::Findable
  extend Persistable::ClassMethods
  extend Nameable
  include Persistable::InstanceMethods

  @@all=[]

  attr_accessor :name
  attr_reader :songs

  def initialize(name)
    @name=name
    @songs=[]
  end

  def self.all
    @@all
  end

  def artists
    self.songs.collect{|song|song.artist}.uniq
  end

end
