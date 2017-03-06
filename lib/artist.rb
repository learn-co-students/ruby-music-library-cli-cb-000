class Artist

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

  def add_song(song)
    if !@songs.include?(song)
      @songs << song
      song.artist=self
    end
  end

  def self.all
    @@all
  end

  def genres
    self.songs.collect {|song| song.genre}.uniq
  end
end
