class Song
  attr_accessor(:name)
  attr_reader(:genre,:artist)
  @@all=[]

  extend(Concerns::Findable)


  def initialize(name,artist=nil,genre=nil)
    @name=name
    self.artist=artist unless artist == nil
    self.genre=genre unless genre == nil
  end

  def self.destroy_all
    @@all=[]
  end

  def save
    @@all << self
  end

  def self.create(song_name)
    song=Song.new(song_name)
    song.save
    song
  end

  def self.all
    @@all
  end

  def artist=(artist)
    @artist=artist unless artist.nil?
    artist.add_song(self) unless artist.nil?
  end

  def genre=(genre)
    if !genre.nil?
      @genre = genre
      genre.songs << self unless genre.songs.include?(self)
    end
  end

  def self.new_from_filename(filename)
    artist_name=filename.split(' - ')[0]
    song_name=filename.split(' - ')[1]
    genre_together=filename.split(' - ')[2]
    genre_name=genre_together.split('.')[0]
    song=Song.find_or_create_by_name(song_name)
    artist=Artist.find_or_create_by_name(artist_name)
    genre=Genre.find_or_create_by_name(genre_name)
    song.artist=artist
    song.genre=genre
    song
  end

  def self.create_from_filename(filename)
    new_from_filename(filename)
  end
end
