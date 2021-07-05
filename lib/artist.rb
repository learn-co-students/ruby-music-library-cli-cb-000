class Artist
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
    artist = Artist.new(name)
    artist.save
    artist
  end

  def songs
    @songs
  end

  def add_song(song)
    song.artist = self if !song.artist
    @songs << song if @songs.none? {|s| s == song}
  end

  def genres
    genres = []
    @songs.each {|song| genres << song.genre}
    genres.uniq
  end

  def self.list_artists
    i = 1
    all.sort_by(&:name).each do |artist|
      puts "#{i}. #{artist.name}"
      i += 1
    end
  end

  def list_songs_by_artist
    i = 1
    @songs.sort_by(&:name).each do |song|
      puts "#{i}. #{song.name} - #{song.genre.name}"
      i += 1
    end
  end
end
