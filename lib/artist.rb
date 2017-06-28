class Artist
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

  def save
    @@all << self
  end

  def self.create( name )
    newArtist = Artist.new( name )
    newArtist.save
    newArtist
  end

  def self.destroy_all
    @@all.clear
  end

  def add_song( song )
    if song.artist == nil
      song.artist = self
    end

    if !@songs.include?(song)
      @songs << song
    end


#    song
  end

  def songs
    @songs
  end

  def genres
    self.songs.collect{ |songs| songs.genre}.uniq
  end

end  # end of class
