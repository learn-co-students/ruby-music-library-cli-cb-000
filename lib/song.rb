class Song

attr_accessor :name, :artist, :genre

extend Concerns::Findable


@@all = []

def initialize(name,artist_object=nil,genre_object=nil)
  @name = name
  self.artist = artist_object
  self.genre = genre_object
  save

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
  song = Song.new(name)
  song
end



def self.new_from_filename(filename)
  song = (filename.split(' - ')[1])
  artist = Artist.create(filename.split(' - ')[0])
  genre = Genre.create(filename.split(' - ')[2].delete!('.mp3'))
  new_song = Song.new(song,artist,genre)
  new_song

end

def self.create_from_filename(filename)
  self.new_from_filename(filename)

end


end
