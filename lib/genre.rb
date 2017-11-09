class Genre
  extend Concerns::Findable
  attr_accessor :name, :songs
  @@all = []

  def initialize(name)
    @name=name
    self.save
    @songs=[]
  end #init

  def save
    @@all << self
  end #save

  def artists
    allartists=[]
    @songs.each { |s| allartists << s.artist}
    allartists.uniq
  end #artists
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
end #class
