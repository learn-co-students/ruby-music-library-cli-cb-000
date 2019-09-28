class Genre

  extend Concerns::Findable

  attr_accessor :name, :songs

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
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
    song = Genre.new(name)
    song.save
    song
  end

  def add_song(song)
      @songs << song if !@songs.include?(song)
      song.genre = self if song.genre == nil
      song
  end

  def artists
    artists = @songs.collect {|song| song.artist}
    artists.uniq
  end

end
