class Song
  attr_accessor :name
  attr_reader :artist , :genre
  @@all = []

  def initialize(name,new_artist=nil,genre=nil)
    @name=name
    self.save
    self.artist=(new_artist)
    self.genre=(genre)
  end #init

  def save
    @@all << self
  end #save

  # *********************************************************************ACCESSOR OVERRIDE
  def artist=(artist)
    @artist=artist
    artist.add_song(self) if !artist.nil?
  end #artist=

  def genre=(genre)
    @genre=genre
    if !genre.nil?
      genre.songs.concat([self]) if !genre.songs.include?(self)
    end
  end #genre=
  # ****************************************************************************CLASS METHODS
  def self.all
    @@all
  end #self.all

  def self.destroy_all
    self.all.clear
  end #self.destroy_all

  def self.create(name)
    self.new(name)
  end #create

  def self.find_by_name(name)
    self.all.detect { |s| s.name == name}
  end #self.find_by_name

  def self.find_or_create_by_name(name)
    song = self.find_by_name(name)
    song = self.create(name) if song.nil?
    song
  end #self.find_or_create_by_name

  def self.new_from_filename(filename)
    filenamesplit=filename.split(/ \- /)                  #splitname based on -
    artistname=filenamesplit[0].strip
    titlename=filenamesplit[1].strip
    genrename=filenamesplit[2].split(".")[0].strip      #removes .mp3 from filename
    artist=Artist.find_or_create_by_name(artistname)    #create artist object
    genre=Genre.find_or_create_by_name(genrename)       #create genre object
    self.new(titlename,artist,genre)                    #create song
  end #self.new_from_filename

  def self.create_from_filename(filename)
    self.new_from_filename(filename)                    #dont need to save since save in init?
  end #self.create_from_filename                        #might need refactor for that if failures
end #class
