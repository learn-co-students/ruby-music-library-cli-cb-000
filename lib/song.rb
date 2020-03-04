class Song
  # attr_accessor :name, :artist
  attr_accessor :name
  # we have custom setters for below
  attr_reader :artist, :genre
  # attr_reader :genre

  @@all=[]

  def initialize(name, artist = nil, genre= nil)
    @name = name
    # @genre = genre
    if !artist.nil?
      # use proper setter syntax!!!
      self.artist = artist
    end
    if !genre.nil?
      self.genre = genre
    end

  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.add_song(self)
  end

  def self.all
    @@all
  end

  def save
    @@all << self
  end

  def self.create(name)
    obj = self.new(name)
    obj.save
    obj
  end

  def self.destroy_all
    self.all.clear
  end

  def self.find_by_name(name)
    @@all.detect{|person| person.name == name}

  end

  def self.find_or_create_by_name(name)
  x = self.find_by_name(name)

  if x.nil?
    self.create(name)
  else
    x
  end
end

def self.artist_name(name)
    Artist.find_or_create_by_name(name)
    #
    # x

  end


  def self.genre_name(name)
      Genre.find_or_create_by_name(name)
      #
      # x

    end

def self.new_from_filename(file)
    # break up the filename
    stuff = file.split(' - ')
    # p stuff
    song = self.new(stuff[1])
    # puts stuff

    # need the genre.

    # why is that method named artist name ?
    artist = self.artist_name(stuff[0])
    genre = self.genre_name(stuff[2].chomp('.mp3'))


    # all the artists are there. on what pass around does this even happen? how would i know?
    # p artist.name
    # artist isnt a class
    artist.add_song(song)
    genre.add_song(song)

    song
  end

  def self.create_from_filename(name)
    @@all << self.new_from_filename(name)
  end

end
