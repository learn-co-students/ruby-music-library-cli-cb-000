class Song
  attr_accessor :name
  attr_reader :artist

  @@all = []

  def self.all
    @@all
  end

  # can be invoked with an optional 'artist' property (song belongs to artist)
  def initialize(name, artist = nil)
    @name = name
    self.artist = artist if artist # ensure that associations (song's 'artist' property) are created upon initialization
    save
  end

  # invokes Artist#add_song to add itself to the artist's collection of songs (artist has many songs)
  def artist=(artist)
    @artist = artist
    artist.add_song(self)
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
end
