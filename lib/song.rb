class Song
  require 'pry'
  attr_accessor :name, :genre
  extend Concerns::Findable


  @@all = []

  def initialize(name, artist_name=nil, genre=nil)
    # save
    @name = name
    if artist_name
        self.artist = artist_name
    end

    if genre
      self.genre = genre
      # artist.add_genre(genre)
    end
  end

  def self.new_from_filename(filename)
    filename = filename.split(" - ")
    name_str = filename[1]
    artist_str = filename[0]
    genre_str = filename[2].split(".")[0]
    # binding.pry
    artist = Artist.find_or_create_by_name(artist_str)
    # binding.pry
    genre = Genre.find_or_create_by_name(genre_str)
    # binding.pry
    song = self.new(name_str, artist, genre)
    # binding.pry
    # genre.save
    # artist.save

    song


  end

  def self.create_from_filename(filename)
    # binding.pry
    song = self.new_from_filename(filename)
    # binding.pry
    song.save
    # binding.pry
    song
  end


  def artist=(artist)
    @artist ||= artist
      @artist.add_song(self)

    end

  def genre=(genre)
      genre.songs << self unless genre.songs.include?(self)
      @genre = genre
    # @genre ||=genre
    #   @genre.add_song(self)
  end

  def artist
    @artist
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear

  end

  def save
    @@all << self
  end

  def self.create(name)
    song = self.new(name)
    # song = Song.new(name)
    song.save
    song
  end


end
