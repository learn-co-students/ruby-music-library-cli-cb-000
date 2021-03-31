class Genre 
  extend Concerns::Findable

attr_accessor :name, :songs

@@all = []

def initialize(name)
  @name = name 
  @songs = []
  end 

def save
  @@all << self 
end 

def self.all
  @@all 
end

def self.destroy_all
  @@all = []
end 

    def self.create(name)
genre = self.new(name)
genre.save
genre
end

def songs 
  @songs 
end

  def artists
    array = []
    @songs.map do |song| 
    if array.include?(song.artist)
      nil 
    else
      array << song.artist
    end
    end 
    array
  end

end