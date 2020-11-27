class Genre

attr_accessor :name
extend Concerns::Findable

def initialize(name)
  @name = name
  save
  @songs = []

end

def save
    @@all << self
end

def self.all
  @@all
end

def self.destroy_all
  @@all =[]
end

def self.create(name)
  song = Genre.new(name)
  song
end

def songs
 Song.all.select{|song| song.genre==self}
end

def artists
  store = []
  self.songs.map do |song|
    if store.include?(song.artist)== false
     store<< song.artist
   end
    end
 return store
end


end
