class Genre
  extend Concerns::Findable
  include Concerns::Savable::InstanceMethods
  extend Concerns::Savable::ClassMethods

  attr_accessor :name, :songs

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.all
    @@all
  end

  # def self.destroy_all
  #   @@all.clear
  # end

  # def save
  #   @@all << self
  # end

  def self.create(name)
    new(name).tap do |x|
      x.save
    end
  end

  def add_song(song)
    song.genre = self unless song.genre == self
    @songs << song unless @songs.include?(song)
  end

  def artists
    self.songs.map do |x|
      x.artist
    end.uniq
  end

  def to_s
    self.name
  end

  # binding.pry
end
