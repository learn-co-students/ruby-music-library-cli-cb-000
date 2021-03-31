class Artist
  attr_accessor :name, :songs
  extend Concerns::SaveRelated::ClassMethods
  include Concerns::SaveRelated::InstanceMethods
  extend Concerns::Findable

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.all
    @@all
  end

  def self.create(name)
    aritst = Artist.new(name)
    aritst.save
    aritst
  end

  def add_song(song)
    @songs << song if !@songs.include?(song)
    song.artist = self if song.artist != self
  end

  def songs
    @songs
  end

  def genres
    self.songs.map { |song| song.genre }.uniq
  end

  def self.print_artists
    self.all.each { |artist| puts "#{artist.name}" }
  end

end
