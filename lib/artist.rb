class Artist

  extend Concerns::Findable

  @@all=[]

  attr_accessor :name
  attr_reader :songs

  def initialize(name)
    @name=name
    @songs=[]
  end

  def add_song(song)
    if !@songs.include?(song)
      @songs << song
      song.artist=self
    end
  end

  def self.all
    @@all
  end

  def self.destroy_all
    self.all.clear
  end

  def save
    @@all << self
  end

  def self.create(name)
    artist=Artist.new(name)
    artist.save
    artist
  end

  def genres
    self.songs.collect {|song| song.genre}.uniq
  end
end
