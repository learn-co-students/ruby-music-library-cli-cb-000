class Artist

  extend Concerns::AllClassMethods
  extend Concerns::Findable
  include Concerns::AllInstanceMethods

  attr_accessor :name
  attr_reader :songs

  @@artists = []

  def initialize(name)
    @name = name
    @songs = []
  end

  #need to link @@artists to the @@all we call in Concerns
  def self.all
    @@artists
  end

  # <class>.create #creates new class instances and calls <instance>.save to push it onto @@all
  def self.create(name)
    #we use .tap so we return the object
    self.new(name).tap{|s| s.save}
  end

  #adds song onto artists @songs list
  def add_song(song)
    #don't add to song collection if we already have it in @songs
    #durr find_by_name searches @@all not @songs doh
    if !@songs.detect{|s| s.name == song.name}
      @songs << song
    end

    #infinite loop until we do if song is not already in artist's list
    song.artist = self if !song.artist
  end

  #returns unique genres belonging to the artist (through songs)
  def genres
    @songs.collect{|song| song.genre }.uniq
  end

end
