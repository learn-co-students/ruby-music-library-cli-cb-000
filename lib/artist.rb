class Artist
  extend Concerns::Findable
  extend Persistable::ClassMethods
  extend Nameable::ClassMethods
  include Persistable::InstanceMethods

  @@all = []

  attr_accessor :name, :songs

  def initialize(name)
    @name = name
    @songs = []
  end

  def genres
    genresObjArr = []

    @songs.each do |s|
      genresObjArr << s.genre
    end

    genresObjArr.uniq
  end

  def add_song(songObj)
    #do not add artist to songObj if artist already exists
    songObj.artist = self unless songObj.artist != nil

    #do not add songObj to songs array, if songObj already exists
    @songs << songObj unless @songs.include?(songObj)
  end

  def save
    @@all << self
  end

  def self.all
    @@all
  end
end
