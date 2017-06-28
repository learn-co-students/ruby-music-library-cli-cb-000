class Genre
  extend Concerns::Findable

  @@all = []

  attr_accessor :name, :songs

  def initialize( name )
    @name = name
    @songs = []
  end

  def self.all
    @@all
  end

  def self.create( name )
    @@all << self
  end

  def save
    @@all << self
  end

  def self.create( name )
    newGenre = Genre.new( name )
    newGenre.save
    newGenre
  end

  def self.destroy_all
    @@all.clear
  end

  def songs
    @songs
  end

  def add_song( song )
    if song.genre == nil
      song.genre = self
    end

    if !@songs.include?(song)
      @songs << song
    end

  end

  def artists
    #self.songs.collect{ |songs| songs.genre}.uniq
    self.songs.collect{ |songs| songs.artist}.uniq
  end

end  # end of class
