class Song

  #extend(classmethods)/include(instancemethods) here
  extend Concerns::AllClassMethods
  extend Concerns::Findable
  include Concerns::AllInstanceMethods

  attr_accessor :name, :genre
  attr_reader :artist

  @@songs = []

  #Song accepts name for song
  #accepts optional artist
  def initialize(name, artist=nil, genre=nil)
    @name = name
    #call our artist= method if we don't have default nil value
    self.artist = artist if artist != nil
    #expect(artist.songs).to include(song)
    self.genre = genre if genre != nil
  end

  #need to link @@songs to the @@all we call in Concerns
  def self.all
    @@songs
  end

  def self.create(name, artist = nil, genre = nil)
    self.new(name, artist, genre).tap{|s| s.save}
  end

  def artist=(artist)
    @artist = artist
    #have artist add song until the songs list already includes it
    artist.add_song(self) unless artist.songs.include?(self)
  end

  def genre=(genre)
    @genre = genre
    genre.songs << self  if !genre.songs.include?(self)
  end

  def self.new_from_filename(file)
    #file is "artist - songname - genre.mp3"
    artist_name, song_name, genre_name = file.split(' - ')
    #remove the .mp3 from genre
    genre_name = genre_name.gsub('.mp3','')


    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre_name)
    self.new(song_name,artist,genre)
  end

  def self.create_from_filename(file)
    #file is "artist - songname - genre.mp3"
    artist_name, song_name, genre_name = file.split(' - ')
    #remove the .mp3 from genre
    genre_name = genre_name.gsub('.mp3','')


    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre_name)
    self.create(song_name,artist,genre)
  end
end
