require 'pry'
# require_relative "../config/environment.rb"

class Artist
  extend Concerns::Findable
  attr_accessor :name
  attr_reader :songs

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
    # self.save
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def save
    @@all << self
  end

  def self.create(name)
    artist = self.new(name)
    artist.save
    artist
  end

  def songs
    @songs
  end

  def add_song(song)

      song.artist = self unless song.artist
      songs << song unless songs.include?(song)
      # @songs.uniq!

  end

  def genres
    # self.songs.collect {|song| song.genre}
    songs.collect { |song| song.genre}.uniq
  end
end




# genre = Genre.new("post-punk")
# genre2 = Genre.new("noise")
# band = Artist.new("Rexy")
# band2 = Artist.new("Black Dice")
# song = Song.new("Don't Turn Me Away",band, genre)
# song = Song.new("Kokomo",band, genre2)
# band.genres

# Song.new("Sexy Sadie",)
# Artist
# song = Song.new("Sexy Sadie")
# song = Song.create("Sexy Sadie")
# pop = Genre.new("Pop")
# ruby ../lib/song.rb
# song.genre = pop
