class Genre
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
    genre = Genre.new(name)
    genre.save
    genre
  end

  def add_song(song)
    @songs << song if !@songs.include?(song)
    song.genre = self if song.genre != self
  end

  def artists
    self.songs.map { |song| song.artist }.uniq
  end

  def self.print_genres
    self.all.each { |genre| puts "#{genre.name}" }
  end

end
