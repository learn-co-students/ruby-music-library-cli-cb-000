class Artist
  attr_accessor :name
  attr_reader :songs

  extend Concerns::Findable

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def save
    @@all << self
  end

  def songs
      @songs
  end

  def genres
    self.songs.collect {|song| song.genre}.uniq
  end

  def add_song(song)
    #####  FLATIRON  #####
    song.artist = self unless song.artist
    songs << song unless songs.include?(song)

    #####  MINE  #####
    # if song_exist?(song) != true
    #   @songs << song
    # end
    # if song.artist == nil
    #   song.artist = self
    # end
  end

  def song_exist?(song)
    if @songs.find { |song_name| song_name == song }
      true
    else
      false
    end
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create(name)
    new_artist = self.new(name)
    new_artist.save
    new_artist
  end

end
