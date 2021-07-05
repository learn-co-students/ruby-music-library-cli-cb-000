class Genre
  extend Concerns::Findable

  @@all = []

  attr_accessor :name

  def initialize(name)
    @name = name
    @songs = []
  end

  def save
    @@all << self
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all = []
  end

  def self.create(name)
    genre = Genre.new(name)
    genre.save
    genre
  end

  def songs
    @songs
  end

  def artists
    artists = []
    @songs.each {|song| artists << song.artist}
    artists.uniq
  end

  def self.list_genres
    i = 1
    all.sort_by(&:name).each do |genre|
      puts "#{i}. #{genre.name}"
      i += 1
    end
  end

  def list_songs_by_genre
    i = 1
    @songs.sort_by(&:name).each do |song|
      puts "#{i}. #{song.artist.name} - #{song.name}"
      i += 1
    end
  end
end
