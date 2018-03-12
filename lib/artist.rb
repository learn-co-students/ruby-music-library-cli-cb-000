class Artist
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
    if song.artist.nil?
      # this line seems suspect. feels like duplication

      # binding.pry
      song.artist = self

      # if the song isnt in the songs array yet, add it
      if !@songs.include?(song)
        @songs << song
        # binding.pry

      end
    end
  end

  def genres
    binding.pry

    @songs.collect do |song|
      # not sure whats the issue.
      # .genre should be the genre obj of each song
      song.genre
    end
  end
end
