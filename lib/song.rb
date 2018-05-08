class Song
  
  attr_reader :name, :artist, :genre
  
  def initialize(name, artist = nil, genre = nil)
    @name = name
    @@all = []
    if !(artist == nil) # @artist = artist
      artist.add_song(self)
    else
      # do nothing
    end
    
    if !(genre == nil) # @genre = genre
      self.genre = genre
    else
      # do nothing
    end
  end
  
  def name=(name)
    @name = name
  end
  
  def self.all
    return @@all
  end
  
  def self.destroy_all
    @@all = []
  end
  
  def save
    @@all << self
  end
  
  def self.create(name)
    newSong = Song.new(name)
    newSong.save
    return newSong
  end
  
  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end
  
  def genre=(genre)
    @genre = genre
    # genre.songs << self
    if (genre.songs.include?(self))
      # do nothing
    else
      genre.songs << self
    end
  end
  
  # def self.find_by_name(name)
  #   @@all.each do |song_object|
  #     if song_object.name = name
  #       return song_object
  #     else
  #       return nil
  #     end
  #   end
  # end
  
  # def self.find_or_create_by_name(song_name)
  #   if (self.find_by_name(song_name))
  #     return self.find_by_name(song_name)
  #   else
  #     # do nothing
  #   end
  #   self.create(song_name)
  # end
  
  def self.find_by_name(name)
    @@all.find { |song| song.name == name }
  end
  
  def self.find_or_create_by_name(name)
    self.find_by_name(name) ? self.find_by_name(name) : self.create(name)
  end
  
  def self.new_from_filename(filename)
    artist, name, genre = filename.gsub(".mp3", "").split(" - ")
    new_song = self.new(name)
    new_song.artist = Artist.find_or_create_by_name(artist)
    new_song.genre = Genre.find_or_create_by_name(genre)
    new_song
  end
  
  def self.create_from_filename(filename)
    artist, name, genre = filename.gsub(".mp3", "").split(" - ")
    new_song = self.new(name)
    new_song.artist = Artist.find_or_create_by_name(artist)
    new_song.genre = Genre.find_or_create_by_name(genre)
    new_song.save
    new_song
  end

end










