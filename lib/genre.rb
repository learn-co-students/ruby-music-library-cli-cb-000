class Genre
  extend Concerns::Findable
  include Persistable::InstanceMethods
  extend Persistable::ClassMethods

  attr_accessor :name
  attr_reader :songs

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.create(name)
    new(name).tap{|s| s.save}
  end

  def self.all
    @@all
  end

  def add_song(song)
    @songs << song unless @songs.include?(song)
    song.genre = self unless song.genre == self
  end

  def artists
    self.songs.collect { |song| song.artist }.uniq
  end
end
