class Artist
      extend Concerns::Findable
  attr_accessor :name
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

 def self.create(artist)
   artist = self.new(artist)
   artist.save
   artist
 end

 def songs
   @songs
 end
 def add_song(song)
   song.artist == self ? song.artist : song.artist = self
   @songs.include?(song) ? @songs : @songs << song
 end



def self.find(name)
  self.all.find {|object| object.name == name}
end

def genres
    self.songs.collect do |song|
      song.genre
    end.uniq
end



end
