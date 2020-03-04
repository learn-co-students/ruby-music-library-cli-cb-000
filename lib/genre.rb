class Genre
  extend Concerns::Findable

  attr_accessor :name
  # attr_reader :name
  @@all=[]

  def initialize(name)
    @name = name
    @songs = []
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

  def songs
    @songs
  end

  def add_song(song)
    # if song.genre.nil?
    # song.genre = self

    if song.genre.nil?
      # binding.pry
      # this line seems suspect. is duplication,
      # seems like itd be harmless tho
      # could be a type of infinite loop tho
      # calling the func inside itself.
      # if i had an infinite loop itd be going crazy when run, tho
      song.genre = self

      # if the song isnt in the songs array yet, add it
    end

    if !@songs.include?(song)
    @songs << song

    # binding.pry
  # end
  end
  end

  def artists
    # binding.pry

    ans = @songs.collect do |song|
      # not sure whats the issue.
      # .genre should be the genre obj of each song
      song.artist
    end

    ans.uniq
  end
end
