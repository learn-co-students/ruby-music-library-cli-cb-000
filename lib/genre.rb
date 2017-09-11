class Genre
  
extend Concerns::Findable

attr_accessor :name, :songs

@@all = []


def initialize(name)
  @name = name
  @songs = []
end

def self.all
  @@all
end

def self.destroy_all
  @@all.clear
end

def save
  @@all << self
end

def self.create(name)
    genre = self.new(name)
    @@all << genre
    genre
  end

  def add_song(song)
    if !self.songs.include?(song)
      self.songs << song
    end

    if song.genre == nil
      song.genre = self
    end
  end

  def artists
      self.songs.collect{|s| s.artist}.uniq
   end
end
