class Genre
  attr_accessor :name, :songs
  @@all = []
  extend Concerns::Findable

  def initialize(name)
    @name = name
    @songs =[]
  end

  def self.all
    @@all
  end

  def save
    @@all << self
  end
  def songs
    @songs

  end
  def artists
      the_songs = songs.map do |s|
         s.artist
       end
       the_songs.uniq
  end

  def self.create(name)
    new_genre = self.new(name)
    new_genre.save
    new_genre
  end

  def self.destroy_all
    @@all.clear
  end

end
