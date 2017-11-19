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

def self.create(genre)
  created_genre = Genre.new(genre)
  created_genre.save
  created_genre
end

def add_song(song)
  song.genre = self unless song.genre
  @songs << song unless @songs.include?(song)
end

def artists
  self.songs.collect{|song| song.artist if song.artist}.uniq
end

end
