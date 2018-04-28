class Genre
  
  extend Concerns::Findable

  attr_accessor :name

  @@all = []

  def self.all
    @@all
  end

  def initialize(name)#,genre)
    @name=name
    @songs=[]
    #@genre=genre
    #genre.add_song(self)
  end

  def save
    self.class.all << self
  end

  def self.create(name)
    new_genre=self.new(name)
    new_genre.save
    new_genre
  end

  def self.destroy_all
    self.all.clear
  end

  def songs
    @songs
  end

  def add_song(song)
    song.genre = self unless song.genre#==nil
    @songs << song unless @songs.include?(song)
  end

  def artists
    artist_array=[]
    @songs.each do |song|
      artist_array<<song.artist unless artist_array.include?(song.artist)
    end
    artist_array
  end

end
