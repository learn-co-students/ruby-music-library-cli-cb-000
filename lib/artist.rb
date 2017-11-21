class Artist

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
  created_artist = Artist.new(name)
  created_artist.save
  created_artist
end

def add_song(song)
  song.artist = self unless song.artist
  @songs << song unless self.songs.include?(song)
end

def genres
  self.songs.collect{|song| song.genre if song.genre}.uniq
end

end
