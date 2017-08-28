class Song

  extend Concerns::Findable

  @@all = []

  attr_accessor :name, :artist, :genre

  def initialize( name, artist=nil, genre=nil )
    @name = name
    if artist
      self.artist = artist
    end
    if genre
      self.genre = genre
    end
  end

  def self.all
    @@all
  end

  def save
    @@all << self
  end

  def self.create( name, artist=nil, genre=nil )
    newSong = Song.new( name, artist, genre )
    #puts "Name:#{name}"
    #puts "newSong Name:#{newSong.name}"
    #puts "All:#{self.all}"
    newSong.save
    #puts "After Save All:#{self.all}"
    newSong
  end

  def self.destroy_all
    @@all.clear
  end

  def artist=( artist )
    @artist = artist
    artist.add_song( self )
  end

  def genre=( genre )
    @genre = genre
    genre.add_song( self )
  end


  #  def self.find_by_name( name )
  #    self.all.detect { |song| song.name == name }
  #  end

  #  def self.find_or_create_by_name( name )
  #    self.find_by_name( name ) || self.create( name )
  #  end

  def self.new_from_filename( filename )
    artistName = filename.split(" - ")[0]
    songName = filename.split(" - ")[1]
    genreName =  filename.split(" - ")[2].gsub(".mp3","")
    #puts "Title:#{songName}:Artist:#{artistName}:Genre:#{genreName}:"
    artist = Artist.find_or_create_by_name( artistName )
    genre = Genre.find_or_create_by_name( genreName )
    newSong = self.new( songName, artist, genre )
  end

  def self.create_from_filename( filename )
    newSong = new_from_filename( filename )
    newSong.save
  end

end  # End of class
