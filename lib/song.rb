require_relative 'concerns/concerns.rb'

class Song

  @@all = []
  attr_accessor :name
  attr_reader :artist, :genre

  def initialize(name, artist_object = nil, genre_object = nil)
    @name = name
    if artist_object != nil
      self.artist = artist_object
    end
    if genre_object != nil
      self.genre = genre_object
    end
    self.save
  end

  def save
    unique = true
    @@all.each do |existing_song|
      if existing_song == self
        unique = false
      end
    end
    if unique == true
      @@all << self
    end
  end

  def self.destroy_all
    @@all = []
  end

  def self.all
    @@all
  end

  def self.create(name, artist_object = nil, genre_object = nil)
    new_song_variable = Song.new(name, artist_object, genre_object)
    new_song_variable.save
    new_song_variable
  end

  def access_artist_variable
    @artist
  end

  def access_artist_variable=(artist)
    @artist = artist
  end

  def access_genre_variable=(genre)
    @genre = genre
  end

  def access_genre_variable
    @genre
  end

  def artist=(artist)
    artist.add_song(self)
  end

  def genre=(genre)
    genre.add_song(self)
    # @genre = genre
    # not_yet_included = true
    # genre.songs.each do |existing_song|
    #   if existing_song == self
    #     not_yet_included = false
    #   end
    # end
    # if not_yet_included == true
    #   genre.songs << self
    # end
  end

  def self.find_by_name(name)
    return_variable = nil
    @@all.each do |song|
      if song.name == name
        return_variable = song
      end
    end
    return_variable
  end

  def self.find_by_artist(artist)
    return_variable = nil
    @@all.each do |song|
      if song.artist == artist
        return_variable = song
      end
    end
    return_variable
  end

  def self.find_by_genre(genre)
    return_variable = nil
    @@all.each do |song|
      if song.genre == genre
        return_variable = song
      end
    end
    return_variable
  end

  def self.find_or_create_by_name(name)
    info = self.find_by_name(name)
    return_variable = nil
    if info == nil
      return_variable = Song.create(name)
    else
      return_variable = info
    end
    return_variable
  end

  def self.new_from_filename(filename)
    # puts "@filename was just set to #{@filename}"
    split_array = filename.split(" - ")
    artist_object = Artist.find_or_create_by_name(split_array[0])
    genre_object = Genre.find_or_create_by_name(split_array[2].split(".")[0])
    new_song = Song.new(split_array[1], artist_object, genre_object)
    new_song.filename = filename
    new_song
  end

  def self.create_from_filename(filename_input)
    new_song_variable = Song.new_from_filename(filename_input)
    new_song_variable.save
    # new_song_variable.filename = filename_input
    new_song_variable
  end

  def filename=(filename)
    @filename = filename
  end

  def filename
    @filename
  end

end
