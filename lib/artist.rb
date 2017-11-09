class Artist
  extend Concerns::Findable

  attr_accessor :name, :songs
  @@all = []

  def initialize(name)
    @name=name
    self.save
    @songs = []
  end #init

  def save
    @@all << self
  end #save

  def add_song(song)
    song.artist=self   if song.artist.nil?             #adds self to song.artist if not assigned
    @songs.concat([song]) if !@songs.include?(song)    #add song to @songs array if not in @songs
  end #add_song

  def genres
    allgenres=[]
    @songs.each {|s| allgenres << s.genre}
    allgenres.uniq
  end #genres

  # # ****************************************************************************CLASS METHODS
  def self.all
    @@all
  end #self.all

  def self.destroy_all
    self.all.clear
  end #self.destroy_all

  def self.create(name)
    self.new(name)
  end #create
end #class
