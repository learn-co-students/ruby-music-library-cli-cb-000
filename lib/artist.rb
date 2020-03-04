class Artist

  extend Concerns::Findable
  attr_accessor :name

  @@all=[]

  def initialize(name)
    @name = name
    @songs = []
  end

  def songs
    @songs
  end

  def self.all
    @@all
  end

  def save
    @@all << self
  end

  def self.create(name)
    obj = self.new(name)
    # should save this specific instance
    obj.save
    obj
  end

  def self.destroy_all
    self.all.clear
  end

  def add_song(song)
    # if song.artist isnt set to anything yet
    # this never fires off, right?
    # how do i pass that test then?
    # if song has artist, dont assign
    if song.artist.nil?
      # binding.pry
      # this line seems suspect. is duplication,
      # seems like itd be harmless tho
      # could be a type of infinite loop tho
      # calling the func inside itself.
      # if i had an infinite loop itd be going crazy when run, tho
      song.artist = self

      # if the song isnt in the songs array yet, add it
    end

    # not sure why i had this inside the above if
    if !@songs.include?(song)
      @songs << song
      # binding.pry

    end
  end

  def genres
    # binding.pry

    # @songs
    # she knows nothing

    ans = @songs.collect do |song|
      # not sure whats the issue.
      # .genre should be the genre obj of each song
      song.genre
    end

    ans.uniq
  end
end
