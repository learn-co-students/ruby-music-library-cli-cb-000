class Artist

  extend Concerns::Findable

  attr_accessor :name

  @@all = []

  def self.all
    @@all
  end

  def initialize(name)#,genre)
    @name=name
    @songs = []
    #@genre=genre
    #genre.add_song(self)
  end

  def save
    self.class.all << self
  end

  def self.create(name)
    new_artist=self.new(name)
    new_artist.save
    new_artist
  end

  def self.destroy_all
    self.all.clear
  end

  def songs
    @songs
  end

  def add_song(song)
    song.artist = self unless song.artist#==nil
    @songs << song unless @songs.include?(song)

  end

  def genres
    genre_array=[]
    @songs.each do |song|
      genre_array<<song.genre unless genre_array.include?(song.genre)
    end
    genre_array
  end

end
