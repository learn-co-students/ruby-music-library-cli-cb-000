class Artist
  attr_accessor(:name)
  @@all=[]

  extend(Concerns::Findable)

  def initialize(name)
    @name=name
    @songs=[]
  end

  def self.destroy_all
    @@all=[]
  end

  def save
    @@all << self
  end

  def self.create(artist_name)
    artist=Artist.new(artist_name)
    artist.save
    artist
  end

  def self.all
    @@all
  end

  def add_song(song)
    song.artist=self unless song.artist != nil
    self.songs << song unless self.songs.include?(song)
    self.songs
  end

  def songs
    @songs
  end

  def genres
    songs=self.songs
    genres=songs.collect{ |song| song.genre }
    genres_uniq=genres.uniq
    genres_uniq
  end



end
