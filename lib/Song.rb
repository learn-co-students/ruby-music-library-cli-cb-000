class Song
  #extend Concerns::Findable::ClassMethods
  #include Concerns::Findable::InstanceMethods
  extend Concerns::Findable

  attr_accessor :name
  attr_reader :artist, :genre
  @@all = []

  def initialize(song_name, artist = nil, genre = nil)
    @name = song_name
    if artist != nil
      self.artist = artist
    end
    if genre != nil
      self.genre = genre
    end
    #save
  end

  def genre=(genre)
    @genre = genre
  #  genre.add_song(self)
    genre.songs << self unless genre.songs.include?(self)
  end

  def artist=(artist)
    @artist = artist
#binding.pry
    artist.add_song(self)
  end

  def self.all
    @@all
  end

  def save
#    @@all << self
    self.class.all << self
  end

  def self.destroy_all
    self.all.clear
  end

  def self.create(name)
    song = Song.new(name)
    song.save
    song
  end

  #def self.find_by_name(song_name)
  #  self.all.detect { |s| s.name == song_name  }
  #end

  #def self.find_or_create_by_name(song_name)
  #  self.find_by_name(song_name) || self.create(song_name)
  #end

  def self.new_from_filename(filename)
    artist_name, song_name, genre_name = filename.split(" - ")
##binding.pry
   #artist = Artist.new(artist_name)
   artist = Artist.create(artist_name)
    #artist = find_or_create_by_name(artist_name)
##binding.pry
   #genre = Genre.new(genre_name.slice(0..-5))
   genre = Genre.create(genre_name.slice(0..-5))
  #  genre = find_or_create_by_name(genre_name.slice(0..-5))
#binding.pry
    #new_song = Song.create(song_name)
    new_song = Song.new(song_name, artist, genre)
    #new_song.artist = artist
#binding.pry
    #new_song
  end

  def self.create_from_filename(filename)

  end

end
