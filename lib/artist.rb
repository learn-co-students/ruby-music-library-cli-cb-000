class Artist
  attr_accessor :name, :songs

  @@all = []

  def self.all
    @@all
  end

  def initialize(name)
    @name = name
    @songs = [] # creates a 'songs' property set to an empty array (artist has many songs)
    save
  end

  def save
    @@all << self
  end

  def self.create(name)
    # create new object with name --> call save method on object --> return object
    new(name).tap { |x| x.save }
  end

  def self.destroy_all
    @@all.clear
  end

  def add_song(song)
    # assigns the current artist to the song's 'artist' property
    # does not assign the artist if the song already has an artist
    song.artist = self unless song.artist

    # adds the song to the current artist's 'songs' collection
    # does not add the song to the current artist's collection of songs if it already exists therein
    @songs << song unless songs.include? song
  end

  # returns a collection of genres for all of the artist's songs (artist has many genres through songs)
  # does not return duplicate genres if the artist has more than one song of a particular genre
  def genres 
    songs.map { |song| song.genre }.uniq
  end
end
