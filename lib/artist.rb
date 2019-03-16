class Artist
  extend Concerns::Findable

  @@all = []

  attr_accessor :name, :songs

  def initialize(name)
    @name = name
    @songs = []
    #puts("Artist::Initialize name=#{@name}")
  end

  def self.create(name)
    artist = Artist.new(name)
    artist.save
    artist
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
      if songObj.artist == nil
        songObj.artist = self
      end

      #do not add songObj to songs array, if songObj already exists
      if !@songs.include?(songObj)
        @songs << songObj
      end
  end

  def save
    @@all << self
  end

  def self.destroy_all
    @@all.clear
  end

  def self.all
    @@all
  end

  def self.printAll
    @@all.each{ |a| puts("Artist:  #{a.name}\n")}
  end
end
