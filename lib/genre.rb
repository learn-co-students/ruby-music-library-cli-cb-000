class Genre
  attr_accessor :name

  extend Concerns::Findable

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def add_song(song)
    if song_exist?(song) != true
      @songs << song
    end
  end

  def song_exist?(song)
    if @songs.find { |song_name| song_name == song }
      true
    else
      false
    end
  end

  def artists
    self.songs.collect {|song| song.artist}.uniq
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

  def songs
    @songs
  end

  def self.create(name)
    new_genre = self.new(name)
    new_genre.save
    new_genre
  end

end
